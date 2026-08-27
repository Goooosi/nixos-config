{ inputs, ... }:
{
  flake.modules.homeManager.packages = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
      vesktop
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      kitty
      firefox
      libsecret
      alsa-tools
      alsa-utils
      easyeffects
      git
      swaybg
      spotify
      pavucontrol
      mpv
      nautilus
      python314
      xwayland-satellite
      gh
      gnome-themes-extra
      tree-sitter
      gcc
      postman
      alsa-scarlett-gui
      reaper
      calf
      lsp-plugins
      usbimager
      proton-vpn
    ];
  };
}

