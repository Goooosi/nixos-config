top@{ ... }:
{
  flake.modules.homeManager.dotfiles =
    { config, lib, ... }:
    let
      repo = top.config.flake.meta.repoPath;
      link = path: config.lib.file.mkOutOfStoreSymlink "${repo}/${path}";

      configDirs = [
        "niri"
        "nvim"
        "kitty"
        "noctalia"
        "mango"
        "tofi"
        "mako"
        "swaylock"
        "swayidle"
        "waybar"
        "fastfetch"
        "swayosd"
      ];
    in
    {
      home.file =
        lib.genAttrs (map (d: ".config/${d}") configDirs) (name: {
          source = link "dotfiles/${lib.removePrefix ".config/" name}";
        })
        // {
          ".config/starship.toml".source = link "dotfiles/starship/starship.toml";
          ".local/share/nixos-assets".source = link "assets";
        };
    };
}
