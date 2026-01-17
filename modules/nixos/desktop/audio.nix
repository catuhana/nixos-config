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

  cfg = config.tuhana.desktop.audio;
  desktopEnabled = config.tuhana.desktop.gnome.enable;
in
{
  options.tuhana.desktop.audio = {
    enable = mkEnableOption "Enable audio" // {
      default = desktopEnabled;
    };
  };

  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;

      pulse.enable = true;
      alsa.enable = true;
    };
  };
}
