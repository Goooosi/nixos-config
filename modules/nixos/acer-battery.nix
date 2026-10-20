{ lib, ... }:
{
  flake.modules.nixos.acer-battery = { config, lib, pkgs, ... }:
  let
    cfg = config.services.acer-battery;
    kernel = config.boot.kernelPackages.kernel;

    acer-wmi-battery = config.boot.kernelPackages.acer-wmi-battery.overrideAttrs (old: {

      preInstall = (old.preInstall or "") + ''
        ${lib.getExe pkgs.kmodigest} acer-wmi-battery.ko
      '';
      postInstall = (old.postInstall or "") + ''
        install -Dm444 -t $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/platform/x86 acer-wmi-battery.ko.cer
      '';
    });
  in {
    options.services.acer-battery = {
      enable = lib.mkEnableOption "Acer 80% Battery Charge Limit Support";
    };

    config = lib.mkIf cfg.enable {
      boot.extraModulePackages = [ acer-wmi-battery ];
      boot.kernelModules = [ "acer-wmi-battery" ];
      boot.extraModprobeConfig = ''
        options acer-wmi-battery enable_health_mode=1
      '';
    };
  };
}
