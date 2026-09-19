{ ... }:
{
  flake.modules.homeManager.desktop = { pkgs, ... }: {
    dconf.enable = true;
    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    programs.swaylock.enable = true; # Super+Alt+L (screen locker)
    services.mako.enable = true;     # notification daemon
    services.swayidle.enable = true; # idle management daemon
    services.polkit-gnome.enable = true;

  };
}
