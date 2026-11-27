{ ... }:
{
  flake.modules.nixos.boot =
    { config, pkgs, ... }:
    let
      tunings = {
        legion = {
          tmpfs = true;
          zswapPool = 15;
          swappiness = 15;
          swapGiB = 16;
        };
        acer = {
          tmpfs = false;
          zswapPool = 25;
          swappiness = 40;
          swapGiB = 8;
        };
        default = {
          tmpfs = false;
          zswapPool = 20;
          swappiness = 30;
          swapGiB = 8;
        };
      };

      tuning = tunings.${config.networking.hostName} or tunings.default;
    in
    {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.systemd-boot.configurationLimit = 10;
      boot.kernelPackages = pkgs.linuxPackages_latest;

      boot.zswap = {
        enable = true;
        compressor = "zstd";
        shrinkerEnabled = true;
        zpool = "zsmalloc";
        maxPoolPercent = tuning.zswapPool;
      };

      boot.tmp = {
        useTmpfs = tuning.tmpfs;
        tmpfsSize = "25%";
        cleanOnBoot = !tuning.tmpfs;
      };

      boot.kernel.sysctl."vm.swappiness" = tuning.swappiness;

      swapDevices = [
        {
          device = "/var/lib/swapfile";
          size = tuning.swapGiB * 1024;
          options = [ "discard=once" ];
        }
      ];

      fileSystems."/".options = [ "noatime" ];
      systemd.services.nix-daemon.environment.TMPDIR = "/var/tmp";
    };
}
