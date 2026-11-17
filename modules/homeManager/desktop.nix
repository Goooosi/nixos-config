{ inputs, ... }:
{
  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    let
      colors = ''
        @define-color accent_bg_color #efcb69;
        @define-color accent_fg_color #1c2124;
        @define-color accent_color #efcb69;
        @define-color destructive_bg_color #de635d;
        @define-color window_bg_color #1c2124;
        @define-color window_fg_color #e6e6e6;
        @define-color view_bg_color #171b1e;
        @define-color headerbar_bg_color #1c2124;
        @define-color popover_bg_color #242a2e;
        @define-color card_bg_color #242a2e;
      '';
    in
    {
      dconf.enable = true;
      dconf.settings."org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "adw-gtk3-dark";
      };

      gtk = {
        enable = true;
        theme = {
          name = "adw-gtk3-dark";
          package = pkgs.adw-gtk3;
        };
        gtk3.extraCss = colors;
        gtk4.extraCss = colors;
      };

      home.packages = with pkgs; [
        hyprpolkitagent
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
        swaybg
        xwayland-satellite
      ];
    };
}
