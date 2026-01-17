{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkIf
    mkEnableOption
    ;

  cfg = config.tuhana.desktop.flatpak;
  desktopEnabled = config.tuhana.desktop.gnome.enable;
in
{
  options.tuhana.desktop.flatpak = {
    enable = mkEnableOption "Enable Flatpak" // {
      default = desktopEnabled;
    };
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
    # TODO: Later might need to enable `fonts.fontsDir`
    # and configure if needed.
  };
}
