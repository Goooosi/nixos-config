{ ... }: {
  flake.modules.homeManager.packages = { pkgs, ... }: {

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
      resources
      usbimager
      vesktop
      wvkbd
      localsend
      lazygit
      librewolf
      fastfetch
      (pkgs.callPackage ../../pkgs/sony-headphones.nix { })
    ];
  };
}
