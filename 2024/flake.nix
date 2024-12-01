{
  description = "Flake for 2024 AoC";

inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};

        dev-deps = with pkgs; [
          elixir_1_16
        ];
      in rec {
        devShell =  pkgs.mkShell
          {
            buildInputs = dev-deps;
          };
      }
    );
}
