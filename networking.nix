{ ... }:
{
  networking = {
    hostName = "MateBookD14";

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    timeServers = [ "time.cloudflare.com" ];

    # Causes hangs on rebuilds,
    # disable for now.
    # useNetworkd = true;
    wireless.iwd.enable = true;
  };
}
