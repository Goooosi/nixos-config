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
    home.file.".config/fuzzel".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/fuzzel";
    home.file.".config/eww".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/eww";
    home.file.".config/mako".source = 
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/mako";
    home.file.".config/swaylock".source = 
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/swaylock";
    home.file.".config/swayidle".source = 
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/swayidle";
    home.file.".config/waybar".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/waybar";

  };
}
