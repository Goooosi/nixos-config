{ ... }:
{
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
