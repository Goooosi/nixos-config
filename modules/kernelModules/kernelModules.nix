{ ... }:
{
  flake.modules.nixos.acer-battery =
    {
      config,
      lib,
      pkgs,
      ...
    }:
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
    in
    {
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
  flake.modules.nixos.legion-fan-curve =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      environment.systemPackages = [ pkgs.lenovo-legion ];
      boot.kernelModules = [ "lenovo-legion" ];
      boot.extraModulePackages = [
        (config.boot.kernelPackages.lenovo-legion-module.overrideAttrs (old: {
          postInstall = (old.postInstall or "") + ''
            for ko in $out/lib/modules/*/kernel/drivers/platform/x86/legion-laptop.ko; do
              ${lib.getExe pkgs.kmodigest} "$ko"
            done
          '';
        }))
      ];

      systemd.services.lenovo-legion-fancurve =
        let
          curveFile = ./legion-fan-curve.yaml;
        in
        {
          description = "Apply custom hardware fan curve for Lenovo Legion";
          wantedBy = [ "multi-user.target" ];
          after = [ "basic.target" ];
          path = with pkgs; [
            bash
            coreutils
          ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
          };
          script = ''
            ${pkgs.lenovo-legion}/bin/legion_cli lockfancontroller-disable
            ${pkgs.lenovo-legion}/bin/legion_cli fan-unlock-enable || true
            ${pkgs.lenovo-legion}/bin/legion_cli fancurve-write-file-to-hw ${curveFile} 
          '';
        };
    };

}
