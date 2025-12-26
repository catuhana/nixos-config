{ inputs, pkgs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.tuhana = {
      home = {
        stateVersion = "26.05";
      };

      programs = {
        gnome-shell = {
          enable = true;

          extensions = with pkgs; [
            {
              package = gnomeExtensions.blur-my-shell;
            }
          ];
        };

        git = {
          enable = true;

          settings = {
            init = {
              defaultBranch = "main";
            };

            user = {
              name = "tuhana";
              email = "tuhana.cat+git@gmail.com";
              signingkey = "~/.ssh/id_ed25519.pub";
            };
          };

          signing = {
            format = "ssh";
            key = "~/.ssh/id_ed25519.pub";
          };
        };
      };
    };
  };
}
