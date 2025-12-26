{ pkgs, ... }:
{
  users = {
    users.tuhana = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
}
