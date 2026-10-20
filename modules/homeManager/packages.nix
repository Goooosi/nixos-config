{ ... }: {
  flake.modules.homeManager.packages = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    programs.obsidian = {
      enable = true;
      vaults.notes.target = "Documents/Obsidian";
      defaultSettings.app = {
        alwaysUpdateLinks = true;
        spellcheck = true;
      };
    };

    home.packages = with pkgs; [
      btop
      firefox
      libsecret
      mpv
      nautilus
      postman
      proton-vpn
      (python314.withPackages (ps: with ps; [
        tkinter
        pillow
      ]))
      resources
      usbimager
      vesktop 
      wvkbd
      localsend
      lazygit
      
    ];
  };
}



