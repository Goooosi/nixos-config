{ lib, ... }:
{
  flake.modules.nixos.misc = { pkgs, ... }: {
    # Set your time zone.
    time.timeZone = "America/New_York";

    # Gnome keyring and nautilus
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.sddm.enableGnomeKeyring = true;
    security.polkit.enable = true;
    security.pam.services.swaylock = { };
    programs.dconf.enable = true;
    services.gvfs.enable = true;
    #theme thingy
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
      ];
      config = {
        mango = {
          default = lib.mkForce [
            "wlr"
            "gtk"
          ];
          "org.freedesktop.impl.portal.ScreenCast" = "wlr";
          "org.freedesktop.impl.portal.Screenshot" = "wlr";
        };
        common = {
          default = [
            "wlr"
            "gtk"
          ];
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
    programs.appimage.package = pkgs.appimage-run.override {
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
