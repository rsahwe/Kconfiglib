{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [ "x86_64-linux" ];
    perSystem = { self', pkgs, lib, ... }: {
      packages = {
        kconfiglib = pkgs.python3Packages.buildPythonPackage {
          pname = "kconfiglib";
          version = "14.1.1a4";

          src = ./.;

          pyproject = true;

          build-system = with pkgs.python3Packages; [ setuptools ];
        };

        default = self'.packages.kconfiglib;
      };
    };
  };
}
