{ inputs, ... }:
{
  flake.modules.homeManager.desktop = { pkgs, ... }: {
    
    programs.noctalia.enable = true;
    dconf.enable = true;
    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    
    programs.swaylock.enable = true; # Super+Alt+L (screen locker)
    services.mako.enable = true;     # notification daemon
    services.swayidle.enable = true; # idle management daemon
    services.polkit-gnome.enable = true;
    home.packages  = with pkgs; [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      swaybg
      gnome-themes-extra
      mpvpaper
    ];

  };
}
