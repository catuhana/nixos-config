{ ... }:
{
  imports = [
    ../../modules/home-manager
  ];

  # FIXME: This should NOT be enabled on server hosts.
  # Related TODO in TODO.md. FIX BEFORE ADDING MORE
  # HOSTS!
  tuhana.programs.vscode.enable = true;

  home.stateVersion = "26.05";
}
