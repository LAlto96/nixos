{ config, pkgs, inputs, ... }:
let my-python-packages = ps: with ps; [
    pandas
    numpy
    requests
    (
      buildPythonPackage rec {
        pname = "shell_gpt";
        version = "0.9.4";
        src = fetchPypi {
          inherit pname version;
          sha256 = "sha256-R4rhATuM0VL/N5+dXf3r9bF2/AVEcQhB2J4KYnxdHbk=";
        };
        doCheck = false;
        format = "pyproject";
        propagatedBuildInputs = [
          # Specify dependencies
          pkgs.python3Packages.numpy
          pkgs.python3Packages.hatchling
          pkgs.python3Packages.rich
          pkgs.python3Packages.distro
          pkgs.python3Packages.typer
          pkgs.python3Packages.requests
        ];
      }
    )
];
in
{
  environment.systemPackages = [
    (pkgs.python3.withPackages my-python-packages)
  ];
}