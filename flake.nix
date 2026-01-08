{
  description = "Tuhana's NixOS Configuration";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/?ref=v1.12.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { config, ... }:
      {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];

        flake = {
          nixosConfigurations =
            let
              mkHost =
                name: systems: extraModules:
                let
                  isMultiSystem = builtins.length systems > 1;
                in
                builtins.listToAttrs (
                  map (system: {
                    name = if isMultiSystem then "${name}.${system}" else name;
                    value = inputs.nixpkgs.lib.nixosSystem {
                      inherit system;

                      specialArgs = { inherit inputs; };

                      modules = [
                        ./hosts/${name}
                        (
                          { ... }:
                          {
                            networking.hostName = name;
                          }
                        )
                      ]
                      ++ extraModules;
                    };
                  }) systems
                );
            in
            mkHost "MateBookD14" [ "x86_64-linux" ] [ ];
        };
      }
    );
}
