{ lib, ... }:
{
  flake.modules.nixos.acer-battery = { config, lib, pkgs, ... }:
  let
    cfg = config.services.acer-battery;
    kernelPkgs = config.boot.kernelPackages;

    acer-wmi-battery = kernelPkgs.acer-wmi-battery.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.pahole ];

      preInstall = (old.preInstall or "") + ''
        ${lib.getExe pkgs.kmodigest} acer-wmi-battery.ko
      '';
      
      postInstall = (old.postInstall or "") + ''
        mkdir -p $out/lib/modules/${kernelPkgs.kernel.modDirVersion}/kernel/drivers/platform/x86
        install -Dm444 acer-wmi-battery.ko.cer $out/lib/modules/${kernelPkgs.kernel.modDirVersion}/kernel/drivers/platform/x86/acer-wmi-battery.ko.cer
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

