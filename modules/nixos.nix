{ inputs, self, ... }:

{
  flake.nixosConfigurations = builtins.mapAttrs (name: _: inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs self; };
    modules = [ (../hosts + "/${name}/default.nix") ];
  }) (builtins.readDir ../hosts);
}

