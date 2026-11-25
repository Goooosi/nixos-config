{ inputs, ... }:
{
  flake.modules.nixos.wm = { pkgs, ... }: {
    imports = [ inputs.mangowm.nixosModules.mango ];
    programs.mango.enable = true;
    programs.niri.enable = true;
    environment.systemPackages = with pkgs; [
      brightnessctl
      playerctl
    ];
  };
}
