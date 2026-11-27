top@{ inputs, ... }:
let
  user = top.config.flake.meta.username;
in
{
  flake.nixosConfigurations.legion = inputs.nixpkgs.lib.nixosSystem {
    modules = [ top.config.flake.modules.nixos.legion ];
  };

  flake.modules.nixos.legion = {
    imports =
      (with inputs.self.modules.nixos; [
        base
        zi
        audio
        game
        nvidia
        legion-fan-curve
        flatpak
      ])
      ++ [
        ./_legion/hardware-configuration.nix
        inputs.nix-flatpak.nixosModules.nix-flatpak
      ];

    home-manager.users.${user}.imports = [ inputs.self.modules.homeManager.music ];

    services.flatpak = {
      packages = [
        "org.jellyfin.JellyfinDesktop"
        "org.kde.kcolorchooser"
        "fr.handbrake.ghb"
      ];
    };
    system.stateVersion = "26.05";
    networking.hostName = "legion";
  };
}
