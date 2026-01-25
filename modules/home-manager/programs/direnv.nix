{ config, lib, ... }:
let
  inherit (lib)
    mkIf
    mkDefault
    mkEnableOption
    ;

  cfg = config.tuhana.programs.direnv;
in
{
  options.tuhana.programs.direnv = {
    enable = mkEnableOption "direnv" // {
      default = true; # Maybe don't enable by default
    };
  };

  config = mkIf cfg.enable {
    programs = {
      direnv = {
        enable = true;
        enableBashIntegration = mkIf config.programs.bash.enable true;

        nix-direnv.enable = true;
      };

      bash.enable = mkDefault true;
    };
  };
}
