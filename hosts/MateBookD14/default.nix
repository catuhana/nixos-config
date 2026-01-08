{ inputs, pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./disks.nix
    ./hardware.nix

    ../../modules/core/boot.nix
    ../../modules/core/environment.nix
    ../../modules/core/locale.nix
    ../../modules/core/networking.nix
    ../../modules/core/nix.nix
    ../../modules/core/security.nix
    ../../modules/core/swap.nix

    ../../modules/desktop/audio.nix
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/gnome.nix

    ../../modules/programs.nix
    ../../modules/services.nix

    # TODO: Refactor to use a single users file?
    ../../users/tuhana/users.nix

    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.default
  ];

  system.stateVersion = "26.05";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };

    users.tuhana = {
      imports = [
        ../../users/tuhana/home-manager/default.nix
      ];
    };
  };
}
