# overlays/resolve-no-multiarch.nix
final: prev:
{
  # Évite le multi-arch (i686) dans l'env FHS → plus de demande CUDA 32-bits
  davinci-resolve = prev.davinci-resolve.override {
    buildFHSEnv = args: prev.buildFHSEnvBubblewrap (args // {
      multiArch = false;
    });
  };

  # Si tu utilises la version Studio, décommente :
  # davinci-resolve-studio = prev.davinci-resolve-studio.override {
  #   buildFHSEnv = args: prev.buildFHSEnvBubblewrap (args // {
  #     multiArch = false;
  #   });
  # };
}
