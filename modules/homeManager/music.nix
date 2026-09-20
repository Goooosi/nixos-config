{ ... }:
{
  flake.modules.homeManager.music = { pkgs, ... }: {
    home.packages = with pkgs; [
      reaper
      alsa-scarlett-gui
      calf
      lsp-plugins
      easyeffects
      pavucontrol
      alsa-utils
      alsa-tools
    ];
  };
}
