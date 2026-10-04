{ ... }:
{
  flake.modules.nixos.noctalia-cache = { ... }: {
    nix.settings = {
      substituters = [ "https://noctalia.cachix.org" ];
      trusted-public-keys = [ "noctalia.cachix.org-1:<key from the noctalia README>" ];
    };
  };
}
