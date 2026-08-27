{ ... }:
{
  flake.modules.homeManager.dotfiles = { ... }: {
    home.file.".config/niri/config.kdl".source = ../../dotfiles/niri/config.kdl;
    home.file.".config/kitty/kitty.conf".source = ../../dotfiles/kitty/kitty.conf;
    home.file.".config/noctalia/config.kdl".source = ../../dotfiles/noctalia/config.toml;
  };
}
