{ self, super, lib, buildGoModule, fetchFromGitHub, fetchpatch, buildEnv, linkFarm, overrideCC, makeWrapper, stdenv, addDriverRunpath, cmake, gcc12, clblast, libdrm, rocmPackages, cudaPackages, darwin, autoAddDriverRunpath, nixosTests, testers, ollama, ollama-rocm, ollama-cuda, config, acceleration ? null }:

let
  preparePatch = patch: hash:
    fetchpatch {
      url = "file://${src}/llm/patches/${patch}";
      inherit hash;
      stripLen = 1;
      extraPrefix = "llm/llama.cpp/";
    };

  validateFallback = lib.warnIf (config.rocmSupport && config.cudaSupport) (lib.concatStrings [
    "both `nixpkgs.config.rocmSupport` and `nixpkgs.config.cudaSupport` are enabled, "
    "but they are mutually exclusive; falling back to cpu"
  ]) (!(config.rocmSupport && config.cudaSupport));

  shouldEnable = mode: fallback: (acceleration == mode) || (fallback && acceleration == null && validateFallback);

  rocmRequested = shouldEnable "rocm" config.rocmSupport;
  cudaRequested = shouldEnable "cuda" config.cudaSupport;

  enableRocm = rocmRequested && stdenv.isLinux;
  enableCuda = cudaRequested && stdenv.isLinux;

  rocmLibs = [
    rocmPackages.clr
    rocmPackages.hipblas
    rocmPackages.rocblas
    rocmPackages.rocsolver
    rocmPackages.rocsparse
    rocmPackages.rocm-device-libs
    rocmPackages.rocm-smi
  ];

  rocmClang = linkFarm "rocm-clang" { llvm = rocmPackages.llvm.clang; };

  rocmPath = buildEnv {
    name = "rocm-path";
    paths = rocmLibs ++ [ rocmClang ];
  };

  cudaToolkit = buildEnv {
    name = "cuda-merged";
    paths = [
      (lib.getBin (cudaPackages.cuda_nvcc.__spliced.buildHost or cudaPackages.cuda_nvcc))
      (lib.getLib cudaPackages.cuda_cudart)
      (lib.getOutput "static" cudaPackages.cuda_cudart)
      (lib.getLib cudaPackages.libcublas)
    ];
  };

  metalFrameworks = with darwin.apple_sdk_11_0.frameworks; [
    Accelerate
    Metal
    MetalKit
    MetalPerformanceShaders
  ];

  wrapperOptions =
    [
      "--suffix LD_LIBRARY_PATH : '${addDriverRunpath.driverLink}/lib'"
    ]
    ++ lib.optionals enableRocm [
      "--suffix LD_LIBRARY_PATH : '${rocmPath}/lib'"
      "--set-default HIP_PATH '${rocmPath}'"
    ];

  wrapperArgs = builtins.concatStringsSep " " wrapperOptions;

  goBuild = if enableCuda then buildGoModule.override { stdenv = overrideCC stdenv gcc12; } else buildGoModule;

in
{
  ollama = super.ollama.overrideAttrs (oldAttrs: rec {
    version = "0.3.2";

    src = fetchFromGitHub {
      owner = "ollama";
      repo = "ollama";
      rev = "v0.3.2";
      hash = "new-sha256-hash-for-0.3.2";
      fetchSubmodules = true;
    };

    vendorHash = "new-sha256-hash-for-vendor";

    llamacppPatches = [
      (preparePatch "01-load-progress.diff" "new-sha256-hash-for-patch-01")
      (preparePatch "02-clip-log.diff" "new-sha256-hash-for-patch-02")
      (preparePatch "03-load_exception.diff" "new-sha256-hash-for-patch-03")
      (preparePatch "04-metal.diff" "new-sha256-hash-for-patch-04")
      (preparePatch "05-default-pretokenizer.diff" "new-sha256-hash-for-patch-05")
      (preparePatch "06-embeddings.diff" "new-sha256-hash-for-patch-06")
      (preparePatch "07-clip-unicode.diff" "new-sha256-hash-for-patch-07")
      (preparePatch "08-pooling.diff" "new-sha256-hash-for-patch-08")
      (preparePatch "09-lora.diff" "new-sha256-hash-for-patch-09")
    ];

    nativeBuildInputs =
      [ cmake ]
      ++ lib.optionals enableRocm [ rocmPackages.llvm.bintools ]
      ++ lib.optionals enableCuda [ cudaPackages.cuda_nvcc ]
      ++ lib.optionals (enableRocm || enableCuda) [
        makeWrapper
        autoAddDriverRunpath
      ]
      ++ lib.optionals stdenv.isDarwin metalFrameworks;

    buildInputs =
      lib.optionals enableRocm (rocmLibs ++ [ libdrm ])
      ++ lib.optionals enableCuda [
        cudaPackages.cuda_cudart
        cudaPackages.cuda_cccl
        cudaPackages.libcublas
      ]
      ++ lib.optionals stdenv.isDarwin metalFrameworks;

    patches = [
      ./disable-git.patch
      ./disable-lib-check.patch
    ] ++ llamacppPatches;

    postPatch = ''
      substituteInPlace version/version.go --replace-fail 0.0.0 '${version}'
    '';

    preBuild = ''
      export OLLAMA_SKIP_PATCHING=true
      go generate ./...
    '';

    postFixup = ''
      mv "$out/bin/app" "$out/bin/.ollama-app"
      '' + lib.optionalString (enableRocm || enableCuda) ''
      wrapProgram "$out/bin/ollama" ${wrapperArgs}
    '';

    ldflags = [
      "-s"
      "-w"
      "-X=github.com/ollama/ollama/version.Version=${version}"
      "-X=github.com/ollama/ollama/server.mode=release"
    ];

    passthru.tests = {
      inherit ollama;
      service = nixosTests.ollama;
      version = testers.testVersion {
        inherit version;
        package = ollama;
      };
    } // lib.optionalAttrs stdenv.isLinux {
      inherit ollama-rocm ollama-cuda;
      service-cuda = nixosTests.ollama-cuda;
      service-rocm = nixosTests.ollama-rocm;
    };

    meta = {
      description = "Get up and running with large language models locally"
        + lib.optionalString rocmRequested ", using ROCm for AMD GPU acceleration"
        + lib.optionalString cudaRequested ", using CUDA for NVIDIA GPU acceleration";
      homepage = "https://github.com/ollama/ollama";
      changelog = "https://github.com/ollama/ollama/releases/tag/v${version}";
      license = licenses.mit;
      platforms = if (rocmRequested || cudaRequested) then platforms.linux else platforms.unix;
      mainProgram = "ollama";
      maintainers = with maintainers; [
        abysssol
        dit7ya
        elohmeier
        roydubnium
      ];
    };
  });
}
