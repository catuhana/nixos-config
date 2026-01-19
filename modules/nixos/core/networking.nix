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

  cfg = config.tuhana.core.networking.resolved;

  DNS = {
    ips = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
    dot = [
      "1.1.1.1#cloudflare-dns.com"
      "1.0.0.1#cloudflare-dns.com"
      "2606:4700:4700::1111#cloudflare-dns.com"
      "2606:4700:4700::1001#cloudflare-dns.com"
    ];
  };
in
{
  options.tuhana.core.networking.resolved = {
    enable = mkEnableOption "Use systemd-resolved for DNS" // {
      default = true;
    };

    mDNS = mkEnableOption "Enable Multicast DNS";
  };

  config = mkMerge [
    {
      networking = {
        nameservers = DNS.ips;
        timeServers = [ "time.cloudflare.com" ];
      };
    }
    (mkIf cfg.enable {
      services.resolved = {
        enable = true;

        settings.Resolve = {
          Domains = [ "~." ];

          DNSOverTLS = true;
          DNSSEC = true;
          MulticastDNS = cfg.mDNS;
          LLMNR = false;

          FallbackDNS = DNS.dot;
        };
      };
    })
  ];
}
