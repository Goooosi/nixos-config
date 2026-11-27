top@{ inputs, ... }:
let
  user = top.config.flake.meta.username;
in
{
  flake.modules.nixos.zi = {
    imports = [ inputs.self.modules.nixos.home-manager ];

    users.users.${user} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };

    home-manager.users.${user}.imports = [ inputs.self.modules.homeManager.zi ];
  };

  flake.modules.homeManager.zi = {
    imports = with inputs.self.modules.homeManager; [
      desktop
      dotfiles
      spicetify
      zsh
      packages
      neovim
      no-noctalia
    ];

    home.stateVersion = "26.05"; 
  };
}
