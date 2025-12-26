{ pkgs, ... }:
{
  users = {
    defaultUserShell = with pkgs; zsh;

    users.tuhana = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
}
