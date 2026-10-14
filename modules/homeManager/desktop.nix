{ inputs, ... }:
{
  flake.modules.homeManager.desktop = { pkgs, ... }: {
    
    programs.waybar.enable = true;
    # programs.noctalia.enable = true;
    dconf.enable = true;
    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    home.packages  = with pkgs; [
      hyprpolkitagent
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      swaybg
      gnome-themes-extra
      xwayland-satellite
    ];
  };
}
