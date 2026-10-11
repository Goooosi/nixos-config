{ inputs, ... }:
{
  flake.modules.homeManager.desktop = { pkgs, ... }: {
    imports = [ inputs.mangobar.homeManagerModules.default ];

    # programs.noctalia.enable = true;
    dconf.enable = true;
    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    home.packages  = with pkgs; [
      hyprpolkitagent
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      swaybg
      wofi
      eww
      gnome-themes-extra
      xwayland-satellite
    ];
    services.mangobar = {
      enable = true;
      systemdTarget = "mango.target";
    };
  };
}
