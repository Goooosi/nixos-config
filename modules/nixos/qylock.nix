{ inputs, ... }:
{
  flake.modules.nixos.qylock = { pkgs, ... }: 
    let
      umbreonTheme = pkgs.stdenvNoCC.mkDerivation {
        name = "umbreon";
        src = ../../umbreon; 
        dontUnpack = true;
        installPhase = ''
          mkdir -p $out/share/sddm/themes/umbreon
          cp -r $src/* $out/share/sddm/themes/umbreon/

          find $out/share/sddm/themes/umbreon -name '*.qml' -exec sed -i \
            -e 's/import QtGraphicalEffects [0-9.]*/import Qt5Compat.GraphicalEffects/' \
            {} +
        '';
      };
    in
    {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        wayland.compositor = "kwin";
        theme = "umbreon"; 
        extraPackages = with pkgs.kdePackages; [
          qtmultimedia
          qtsvg
          qt5compat
          qtshadertools
          pkgs.bibata-cursors 
        ];
        settings = {
          Theme = {
            cursorTheme = "Bibata-Modern-Ice";
            cursorSize = 24;
          };
        };
      };

      systemd.services.display-manager.environment = {
        KWIN_FORCE_SW_CURSOR = "1";
        XCURSOR_THEME = "Bibata-Modern-Ice";
        XCURSOR_SIZE = "24"; 
        XCURSOR_PATH = "${pkgs.bibata-cursors}/share/icons";
      };

      environment.systemPackages = with pkgs; [
        bibata-cursors 
        gst_all_1.gstreamer
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-plugins-ugly
        gst_all_1.gst-libav
        umbreonTheme 
      ];
      environment.sessionVariables = {
        XCURSOR_THEME = "Bibata-Modern-Ice";
        XCURSOR_SIZE = "24";
      };
    };
}





