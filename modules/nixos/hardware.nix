{ ... }:
{
  flake.modules.nixos.hardware = { ... }: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  }; 
}
