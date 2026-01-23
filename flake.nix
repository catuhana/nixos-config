{
  description = "Tuhana's Nix configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      disko,
      lanzaboote,
    }@inputs:
    let
      inherit (nixpkgs)
        lib
        ;

      perSystem =
        f:
        let
          allSystems = lib.systems.flakeExposed;

          systemOutputs = lib.genAttrs allSystems (
            system:
            f {
              inherit system inputs;

              pkgs = import nixpkgs {
                inherit system;
              };
            }
          );
          outputNames = lib.unique (
            lib.concatLists (lib.mapAttrsToList (_: v: lib.attrNames v) systemOutputs)
          );
        in
        lib.genAttrs outputNames (outputName: lib.genAttrs allSystems (system: systemOutputs.${system}.${outputName}));
    in
    {
      nixosConfigurations =
        let
          mkSystem = hostName: system: {
            ${hostName} = lib.nixosSystem {
              inherit system;

              specialArgs = {
                inherit hostName;
              };

              modules = [
                home-manager.nixosModules.home-manager
                disko.nixosModules.default
                lanzaboote.nixosModules.lanzaboote
              ]
              ++ [
                ./hosts/${hostName}
              ];
            };
          };
        in
        mkSystem "MateBookD14" "x86_64-linux";
    }
    // perSystem (
      { pkgs, ... }:
      {
        formatter = pkgs.nixfmt-tree;
      }
    );
}
