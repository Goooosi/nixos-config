{ ... }:
{
  flake.modules.homeManager.dotfiles = { config, pkgs, ... }: {
    home.file.".config/niri/config.kdl".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/niri/config.kdl";
    home.file.".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/nvim";
    home.file.".config/kitty".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/kitty";
    home.file.".config/noctalia".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/noctalia";
    home.file.".config/mango".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/mango";
    home.file.".config/wofi".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/wofi";
    home.file.".config/eww".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/eww";
    home.file.".config/mangobar".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/mangobar";
  };
}
