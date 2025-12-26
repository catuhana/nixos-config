{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      git
      msedit
    ];

    variables = {
      EDITOR = "edit";
      VISUAL = "edit";
    };

    shellAliases = {
      ".." = "cd ..";
    };
  };
}
