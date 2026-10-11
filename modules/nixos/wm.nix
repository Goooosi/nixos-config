{ ... }:
{
  flake.modules.nixos.wm = { pkgs, inputs, ... }: {
    imports = [ inputs.mangowm.nixosModules.mango ];
    programs.mango.enable = true;
    programs.niri.enable = true; 
  };
}
