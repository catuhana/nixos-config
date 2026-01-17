{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkIf
    mkMerge
    mkOption
    mkEnableOption
    types
    ;

  cfg = config.tuhana.core.networking;

  dnsProviders = {
    cloudflare = {
      ips = [ "1.1.1.1" "1.0.0.1" ];
      dot = [ "1.1.1.1#cloudflare-dns.com" "1.0.0.1#cloudflare-dns.com" ];
    };
  };
  selectedDnsProvider = dnsProviders.${cfg.dns.provider};
in
{
  options.tuhana.core.networking = {
    dns.provider = mkOption {
      type = types.enum [ "cloudflare" ];
      default = "cloudflare";
    };

    resolved.enable = mkEnableOption "Use systemd-resolved for DNS";
  };

  config = mkMerge [
    {
      networking = {
        nameservers = selectedDnsProvider.ips;
        timeServers = [ "time.cloudflare.com" ];
      };
    }
    (mkIf cfg.resolved.enable {
      services.resolved = {
        enable = true;

        settings.Resolve = {
          DNSOverTLS = true;
          DNSSEC = true;
          Domains = [ "~." ];
          FallbackDNS = selectedDnsProvider.dot;
        };
      };
    })
  ];
}
