{ inputs, ... }: 
{
  flake.modules.homeManager.spicetify = { pkgs, ... }: {
    imports = [ inputs.spicetify-nix.homeManagerModules.spicetify ]; 
    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
      in
      {
        enable = true;

        theme = {
          name = "Ziro";
          src = spicePkgs.themes.ziro.src;
          injectCss = true;
          injectThemeJs = true;
          replaceColors = true;
          overwriteAssets = true;
          
  
           additionalCss = '' 
            :root {
              --spice-main: #1C2124 !important;
              --spice-sidebar: #1C2124 !important;
              --spice-player: #1C2124 !important;
              --mod-main-bg: #1C2124 !important;
              --spice-card: #1C2124 !important;
            }

            html, body, #main, .Root__bg, .main-view-container {
              background-color: #1C2124 !important;
              background-image: none !important;
            }

            .main-topBar-container,
            .main-topBar-background,
            .main-topBar-overlay {
              background-color: transparent !important;
              background: transparent !important;
              box-shadow: none !important;
            }

            .main-entityHeader-container {
              padding-top: 90px !important;
              position: relative !important;
              z-index: 1 !important;
            }

            .main-entityHeader-topbarContent,
            .main-home-filterChipsContainer {
              display: none !important;
              height: 0px !important;
              visibility: hidden !important;
            }

            .main-trackList-trackList,
            [role="grid"],
            .main-trackList-indexableElement {
              border: none !important;
              box-shadow: none !important;
              background-color: transparent !important;
            }

            [data-testid="tracklist-row"],
            .main-trackList-trackListRow {
              background-color: rgba(28, 33, 36, 0.6) !important;
              border-radius: 4px;
              border: none !important; 
              box-shadow: none !important;
            }

            .main-trackList-trackListRowGrid,
            [role="row"] {
              border: none !important;
              border-bottom: none !important;
              box-shadow: none !important;
            }

            [data-testid="tracklist-row"]:hover,
            .main-trackList-trackListRow:hover {
              background-color: #414E54 !important;
            }

            [data-testid="playback-position"],
            [data-testid="playback-duration"] {
              position: absolute !important;
              bottom: 3px !important;
              display: inline-block !important;
              visibility: visible !important;
              opacity: 0.9 !important;
              z-index: 9999 !important;
              font-size: 12.5px !important;
            }

            [data-testid="playback-position"] {
              right: 48px !important;
            }

            [data-testid="playback-duration"] {
              right: -3.5px !important;
            }
          '';


        };

        customColorScheme = {
          text               = "EFCB69";
          subtext            = "FFFFFF"; 
          main               = "1C2124";
          sidebar            = "1C2124"; 
          player             = "1C2124";
          card               = "1C2124";
          shadow             = "000000";
          selected-row       = "414E54"; 
          button             = "EFCB69"; 
          button-active      = "DE635D";
          button-disabled    = "414E54";
          tab-active         = "EFCB69";
          notification       = "DE635D"; 
          notification-error = "DE635D";
          misc               = "FFFFFF";
        };
      };

  };

}
