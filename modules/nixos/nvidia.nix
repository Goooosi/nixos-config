{ config, ... }:
{
flake.modules.nixos.nvidia = { config, pkgs, ... }: {
   # Video Drivers
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      amdgpuBusId = "PCI:53:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
};
}
