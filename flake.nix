{
  description = "Tuhana's Nix Configuration(s)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/latest";
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
              mkSystem =
                hostName: systems:
                builtins.listToAttrs (
                  map (
                    system:
                    let
                      attrName = if builtins.length systems > 1 then "${hostName}.${system}" else hostName;
                    in
                    {
                      name = attrName;

                      value = inputs.nixpkgs.lib.nixosSystem {
                        inherit system;

                        specialArgs = { inherit inputs; };

                        modules = [
                          ./hosts/${hostName}
                          (
                            { ... }:
                            {
                              networking.hostName = hostName;
                            }
                          )
                        ];
                      };
                    }
                  ) systems
                );
            in
            mkSystem "MateBookD14" [ "x86_64-linux" ];
        };

        perSystem =
          { pkgs, ... }:
          {
            formatter = pkgs.nixfmt-tree;
          };
      }
    );
}
