{ ... }:
{
  imports = [
    ./desktop/gnome.nix

    ./programs/direnv.nix
    ./programs/gh.nix
    ./programs/git.nix
    ./programs/vscode.nix
  ];
}
