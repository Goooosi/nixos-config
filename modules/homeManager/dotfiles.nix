{ ... }:
{
  flake.modules.homeManager.dotfiles = { config, ... }: {
    home.file.".config/niri/config.kdl".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/niri/config.kdl";
    home.file.".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/nvim";

    xdg.configFile."kitty".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/kitty";

    home.file.".config/noctalia/config.toml".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/noctalia/config.toml";
  };
}
