{ pkgs, inputs, ... }:
{
flake.modules.nixos.misc= { pkgs, lib, ... }: {
  #zsh shell
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
   
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Gnome keyring and nautilus
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  security.polkit.enable = true;
  security.pam.services.swaylock = {};
  programs.dconf.enable = true;
  services.gvfs.enable = true;
  #theme thingy
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-gnome ];
    config = {
      mango = {
        default = lib.mkForce [ "wlr" "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        "org.freedesktop.impl.portal.Screenshot" = "wlr";
      };
      common = {
        default = [ "wlr" "gtk" ];
      };
    };
  };
  #gtk = {
    #enable = true;
    #theme = {
      #name = "Adwaita-dark";
      #package = pkgs.gnome-themes-extra;
    #};
  #};
  #app image
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.appimage.package =
    pkgs.appimage-run.override {
      extraPkgs = pkgs: [
        pkgs.python312
      ];
    };
  # Nix compalibility
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    alsa-lib
    libX11
    libXcursor
    libXrandr
    libXext
  ];
  programs.gpu-screen-recorder = {
      enable = true;
      ui.enable = true;
    };
  };
}
