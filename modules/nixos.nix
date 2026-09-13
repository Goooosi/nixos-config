{ inputs, ... }:
{
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ../hosts/laptop
      inputs.home-manager.nixosModules.default
      {
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users.zi = {
          imports = [
            ../home.nix
            inputs.self.modules.homeManager.shell
            inputs.self.modules.homeManager.desktop
            inputs.self.modules.homeManager.packages
	    inputs.self.modules.homeManager.dotfiles
	    inputs.self.modules.homeManager.neovim
	    inputs.self.modules.homeManager.flatpak
          ];
        };
        home-manager.users.admin = {
          imports = [
            inputs.self.modules.homeManager.shell
          ];
          home.stateVersion = "26.05";
        };
      }
    ];
  };
}
