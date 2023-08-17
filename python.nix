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
        propagatedBuildInputs = with pkgs.python3Packages; [
          # Specify dependencies
          numpy
          hatchling
          rich
          distro
          typer
          requests
        ];
      }
    )
    (
];
in
{
  environment.systemPackages = [
    (pkgs.python3.withPackages my-python-packages)
  ];
}
