top@{ inputs, ... }:
let
  user = top.config.flake.meta.username;
in
{
  flake.modules.nixos.zi = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    users.users.root.hashedPassword = "!";
    users.users.${user} = {
      isNormalUser = true;
      description = user;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${user}.imports = [ inputs.self.modules.homeManager.zi ];
    };
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

    home = {
      username = user;
      homeDirectory = "/home/${user}";
      stateVersion = top.config.flake.meta.stateVersion;
    };
  };
}
