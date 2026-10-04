{ ... }:
{
  flake.modules.nixos.boot = { pkgs, ... }: {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.configurationLimit = 10;
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.zswap = {
      enable = true;
      compressor = "zstd";
      maxPoolPercent = 25;
      shrinkerEnabled = true;
      zpool="zsmalloc"; 
    };
    boot.kernel.sysctl = { "vm.swappiness" = 10; };
  };
}
