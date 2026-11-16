# modules/users.nix
{ inputs, ... }:
{
  flake.modules.nixos.zi = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    users.users.root.hashedPassword = "!";
    users.users.zi = {
      isNormalUser = true;
      description = "zi";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs; };
      users.zi = {
        home = {
          username = "zi";
          homeDirectory = "/home/zi";
          stateVersion = "26.05";
        };
        imports = with inputs.self.modules.homeManager; [
          desktop dotfiles spicetify zsh packages neovim no-noctalia
        ];
      };
    };
  };
}
