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
        theme = "umbreon"; 
        settings = {
          Theme = {
            CursorTheme = "Bibata-Modern-Ice";
            CursorSize = 24;
          };
        };

        extraPackages = with pkgs.kdePackages; [
          qtmultimedia
          qtsvg
          qt5compat
          qtshadertools
        ];
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



