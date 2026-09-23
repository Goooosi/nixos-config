{ inputs, ... }:
{
  flake.modules.homeManager.packages = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    imports = [
      inputs.spicetify-nix.homeManagerModules.spicetify
    ];
    programs.obsidian = {
      enable = true;
      vaults.notes.target="Documents/Obsidian";
      defaultSettings.app={
	alwaysUpdateLinks = true;
	spellcheck = true;
      };
    };

    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
      in
      {
        enable = true;

        theme = {
	  src = spicePkgs.themes.ziro.src;
	  name = "Ziro";

	  injectCss = true;
	  injectThemeJs = true;
	  replaceColors = true;
	  overwriteAssets = true;
	  additionalCss = '' 
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
        colorScheme = "rose-pine-moon";
      };

 
    home.packages = with pkgs; [
      vesktop
      firefox
      libsecret
      mpv
      nautilus
      python314
      xwayland-satellite
      postman
      usbimager
      proton-vpn
      resources
      btop
    ];
  };
}

