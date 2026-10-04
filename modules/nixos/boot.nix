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
      shrinkerEnabled = true;
      zpool="zsmalloc"; 
    };
  };
}
