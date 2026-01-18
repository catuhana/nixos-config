{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkIf
    mkOption
    mkEnableOption
    types
    ;

  cfg = config.tuhana.desktop.gnome;
in
{
  options.tuhana.desktop.gnome = {
    enable = mkEnableOption "GNOME desktop environment";
  };

  config = mkIf cfg.enable {
    fonts.enableDefaultPackages = true;

    services = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;

      gnome = {
        core-developer-tools.enable = false;
        games.enable = false;
      };
    };

    programs.dconf.profiles.user.databases = [
      {
        settings = {
          "org/gnome/mutter" = {
            experimental-features = [
              "scale-monitor-framebuffer" # Fractional scaling
              "variable-refresh-rate"
              "xwayland-native-scaling"
              "autoclose-xwayland"
            ];
          };
        };
      }
    ];
  };
}
