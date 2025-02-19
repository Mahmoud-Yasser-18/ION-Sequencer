{
  description = "Ion Sequencer Python package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }: 
    let 
      system = "x86_64-linux";  
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.python312
          pkgs.python312Packages.mpmath
          pkgs.python312Packages.numpy
          pkgs.python312Packages.sympy
        ];
      };
    };
}
