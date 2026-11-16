{ inputs, self, lib, ... }:
{
  flake.nixosConfigurations = lib.mapAttrs
    (name: _: inputs.nixpkgs.lib.nixosSystem {specialArgs = { inherit inputs self; };
      modules = [ ../hosts/${name} ];
    })
    (lib.filterAttrs (_: type: type == "directory") (builtins.readDir ../hosts));
}
