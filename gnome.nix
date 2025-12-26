{ pkgs, ... }:
{
  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;

    gnome = {
      core-apps.enable = true;
      core-developer-tools.enable = false;
      games.enable = false;
    };

    flatpak.enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [
    epiphany
    gnome-contacts
    gnome-maps
    gnome-music
    simple-scan
    gnome-tour
    gnome-connections
    geary
  ];

  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/mutter" = {
          experimental-features = [
            "scale-monitor-framebuffer"
            "xwayland-native-scaling"
          ];
        };
      };
    }
  ];
}
