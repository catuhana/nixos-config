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

      # networking.resolved.enable = true;

      nix.gc.enable = true;

      security = {
        apparmor.enable = true;
        tpm2.enable = true;
      };
    };

    desktop.gnome.enable = true;

    programs.nix-ld.enable = true;
    services.userborn.enable = true;
  };
}
