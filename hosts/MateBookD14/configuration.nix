{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  tuhana = {
    core = {
      boot = {
        silentBoot.enable = true;
        plymouth.enable = true;
      };

      locale.timeZone = "Europe/Istanbul";

      security = {
        apparmor.enable = true;
        tpm2.enable = true;
      };

      nix.gc.enable = true;
    };

    desktop.gnome.enable = true;

    programs.nix-ld.enable = true;
    services.userborn.enable = true;
  };

  # TODO: Maybe import this for every host?
  home-manager.users.tuhana = import ../../users/tuhana/home.nix;

  system.stateVersion = "26.05";
}
