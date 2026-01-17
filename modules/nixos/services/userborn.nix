{ config, lib, ... }:
let
  inherit (lib)
    mkIf
    mkEnableOption
    ;

  cfg = config.tuhana.services.userborn;
in
{
  options.tuhana.services.userborn = {
    enable = mkEnableOption "Enable Userborn";
  };

  config = mkIf cfg.enable {
    services.userborn.enable = true;
  };
}
