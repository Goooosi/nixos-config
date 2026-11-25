top@{ inputs, ... }:
{
  flake.nixosConfigurations.acer = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; }; # see the note below
    modules = [ top.config.flake.modules.nixos.acer ];
  };

  flake.modules.nixos.acer = {
    imports =
      (with inputs.self.modules.nixos; [
        base
        zi
        acer-battery
      ])
      ++ [ ./_acer/hardware-configuration.nix ];

    services.acer-battery.enable = true;

    system.stateVersion = "26.05";
    networking.hostName = "acer";
  };
}
