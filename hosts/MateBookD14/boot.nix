{ pkgs, ... }:
{
  boot = {
    kernelParams = [
      "i915.force_probe=!46a6"
      "xe.force_probe=46a6"
    ];

    plymouth.enable = true;
  };
}
