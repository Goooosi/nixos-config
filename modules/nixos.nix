{ inputs, ... }:

{
  flake.nixosConfigurations = builtins.mapAttrs (name: _: inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [ (../hosts + "/${name}/default.nix") ];
  }) (builtins.readDir ../hosts);
}

