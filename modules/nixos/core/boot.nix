{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkIf
    mkForce
    mkMerge
    mkOption
    mkEnableOption
    types
    ;

  cfg = config.tuhana.core.boot;
in
{
  options.tuhana.core.boot = {
    kernel = mkOption {
      type = types.raw;
      default = pkgs.linuxPackages_latest;
    };

    secureBoot.enable = mkEnableOption "Enable Secure Boot";
    silentBoot.enable = mkEnableOption "Enable silent boot";
    plymouth.enable = mkEnableOption "Enable Plymouth";
  };

  config = mkMerge [
    {
      boot = {
        kernelPackages = cfg.kernel;

        loader = {
          systemd-boot = {
            enable = true;
            editor = false;
          };

          efi.canTouchEfiVariables = true;
          timeout = 0;
        };

        initrd = {
          systemd = {
            enable = true;
            dmVerity.enable = true;
          };

          nix-store-veritysetup.enable = true;
        };

        tmp.cleanOnBoot = true;
      };
    }

    (mkIf cfg.secureBoot.enable {
      environment.systemPackages = with pkgs; [
        sbctl
      ];

      boot = {
        loader.systemd-boot.enable = mkForce false;

        lanzaboote = {
          enable = true;

          pkiBundle = "/var/lib/sbctl";

          autoGenerateKeys.enable = true;
          autoEnrollKeys.enable = true;
        };
      };
    })

    (mkIf cfg.silentBoot.enable {
      boot = {
        kernelParams = [
          "quiet"
          "udev.log_level=3"
        ];

        consoleLogLevel = 0;
        initrd.verbose = false;
      };
    })

    (mkIf cfg.plymouth.enable {
      boot.plymouth.enable = true;
    })
  ];
}
