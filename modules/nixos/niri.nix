{ ... }:
{
  flake.modules.nixos.niri = { pkgs, ... }: {
    programs.niri.enable = true; 
  };
}
