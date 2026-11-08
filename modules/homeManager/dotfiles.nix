{ ... }:
{
  flake.modules.homeManager.dotfiles = { config, lib, ... }:
    let
      repo = config.my.repoPath;
      link = path: config.lib.file.mkOutOfStoreSymlink "${repo}/${path}";

      # ~/.config/<name>  ->  <repo>/dotfiles/<name>
      configDirs = [
        "niri" "nvim" "kitty" "noctalia" "mango" "tofi" "mako"
        "swaylock" "swayidle" "waybar" "fastfetch" "swayosd"    
      ];
    in
    {
      options.my.repoPath = lib.mkOption {
        type = lib.types.str;
        default = "/etc/nixos";
        example = "/home/zi/nixos-config";
        description = ''
          where the config/repo is
        '';
      };

      config = {
        home.file =
          lib.genAttrs (map (d: ".config/${d}") configDirs)
            (name: { source = link "dotfiles/${lib.removePrefix ".config/" name}"; })
          // {
            ".local/share/nixos-assets".source = link "assets";
          };
      };
    };
}
