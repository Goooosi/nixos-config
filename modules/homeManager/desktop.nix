{ inputs, ... }:
{
  flake.modules.homeManager.desktop = { pkgs, ... }: { 
    # programs.noctalia.enable = true;
    dconf.enable = true;
    dconf.settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
    };
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    };

    home.packages  = with pkgs; [
      hyprpolkitagent
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      swaybg
      gnome-themes-extra
      xwayland-satellite
    ];
  };
}
