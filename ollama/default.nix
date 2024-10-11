{ pkgs }:

let
  ollama = import ./ollama.nix { inherit pkgs; };
in
{
  ollama = ollama;
}
