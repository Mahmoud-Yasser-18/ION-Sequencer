{
  description = "Ion Sequencer Python package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        python = pkgs.python3;
      in {
        packages = rec {
          default = ion-sequencer;
          ion-sequencer = python.pkgs.buildPythonPackage rec {
            pname = "ion-sequencer";
            version = "0.1.0";
            src = ./.;
            propagatedBuildInputs = [ 
              python.pkgs.numpy
              python.pkgs.sympy
            ];
            checkInputs = [ python.pkgs.pytest ];
            checkPhase = "pytest tests/";
          };
        };

        devShells.default = pkgs.mkShell {
          packages = [
            (python.withPackages (ps: [
              ps.numpy
              ps.sympy
              ps.pytest
              ps.black
              ps.flake8
            ]))
          ];
        };
      });
}