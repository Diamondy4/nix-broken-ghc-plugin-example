{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/dcd9828e7b43cd6e103951b5fefa6215562a0a67";
    flake-parts.url = "github:hercules-ci/flake-parts";
    haskell-flake.url = "github:srid/haskell-flake";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [
        inputs.haskell-flake.flakeModule
      ];

      perSystem = {
        self',
        pkgs,
        lib,
        config,
        ...
      }: {
        haskellProjects.default = {};
        packages.default = self'.packages.example;
      };
    };
}
