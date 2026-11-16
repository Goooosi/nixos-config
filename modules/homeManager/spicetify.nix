{ inputs, ... }: 
{
  flake.modules.homeManager.spicetify = { pkgs, ... }: {
    imports = [ inputs.spicetify-nix.homeManagerModules.spicetify ]; 
    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
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
          
  
          additionalCss = builtins.readFile ../../dotfiles/spicetify/custom.css;
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
