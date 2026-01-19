{
  config,
  lib,
  ...
}:
let
  inherit (lib)
    mkIf
    mkEnableOption
    ;

  cfg = config.tuhana.core.home-manager;
in
{
  options.tuhana.core.home-manager = {
    enable = mkEnableOption "Home Manager configuration" // {
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      backupFileExtension = "bak";
    };
  };
}
