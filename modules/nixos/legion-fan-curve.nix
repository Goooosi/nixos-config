{ ... }:
{
  flake.modules.nixos.legion-fan-curve = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.lenovo-legion ];
    boot.kernelModules = [ "lenovo-legion-module" ];
    boot.extraModulePackages = with pkgs.linuxPackages; [ lenovo-legion-module ];
    
    systemd.services.lenovo-legion-fancurve = let
      curveFile = pkgs.writeText "fan-curve.conf" ''
        name: "Aggressive NixOS Curve Max Speed"
        entries:
        - fan1_speed: 0
          fan2_speed: 0
          cpu_lower_temp: 0
          cpu_upper_temp: 51
          gpu_lower_temp: 0
          gpu_upper_temp: 58
          ic_lower_temp: 0
          ic_upper_temp: 36
          acceleration: 2
          deceleration: 2
        - fan1_speed: 1600
          fan2_speed: 1600
          cpu_lower_temp: 49
          cpu_upper_temp: 51
          gpu_lower_temp: 55
          gpu_upper_temp: 58
          ic_lower_temp: 34
          ic_upper_temp: 39
          acceleration: 2
          deceleration: 2
        - fan1_speed: 2000
          fan2_speed: 2000
          cpu_lower_temp: 49
          cpu_upper_temp: 51
          gpu_lower_temp: 55
          gpu_upper_temp: 58
          ic_lower_temp: 37
          ic_upper_temp: 44
          acceleration: 2
          deceleration: 2
        - fan1_speed: 2400
          fan2_speed: 2400
          cpu_lower_temp: 49
          cpu_upper_temp: 54
          gpu_lower_temp: 55
          gpu_upper_temp: 58
          ic_lower_temp: 41
          ic_upper_temp: 127
          acceleration: 2
          deceleration: 2
        - fan1_speed: 2800
          fan2_speed: 2800
          cpu_lower_temp: 52
          cpu_upper_temp: 61
          gpu_lower_temp: 55
          gpu_upper_temp: 58
          ic_lower_temp: 127
          ic_upper_temp: 127
          acceleration: 2
          deceleration: 2
        - fan1_speed: 3200
          fan2_speed: 3200
          cpu_lower_temp: 59
          cpu_upper_temp: 64
          gpu_lower_temp: 55
          gpu_upper_temp: 58
          ic_lower_temp: 127
          ic_upper_temp: 127
          acceleration: 2
          deceleration: 2
        - fan1_speed: 3600
          fan2_speed: 3600
          cpu_lower_temp: 62
          cpu_upper_temp: 66
          gpu_lower_temp: 55
          gpu_upper_temp: 58
          ic_lower_temp: 127
          ic_upper_temp: 127
          acceleration: 2
          deceleration: 2
        - fan1_speed: 4000
          fan2_speed: 4000
          cpu_lower_temp: 65
          cpu_upper_temp: 69
          gpu_lower_temp: 55
          gpu_upper_temp: 58
          ic_lower_temp: 127
          ic_upper_temp: 127
          acceleration: 2
          deceleration: 2
        - fan1_speed: 4800
          fan2_speed: 4800
          cpu_lower_temp: 67
          cpu_upper_temp: 75
          gpu_lower_temp: 55
          gpu_upper_temp: 65
          ic_lower_temp: 127
          ic_upper_temp: 127
          acceleration: 2
          deceleration: 2
        - fan1_speed: 5600
          fan2_speed: 5600
          cpu_lower_temp: 70
          cpu_upper_temp: 82
          gpu_lower_temp: 62
          gpu_upper_temp: 72
          ic_lower_temp: 127
          ic_upper_temp: 127
          acceleration: 2
          deceleration: 2
        - fan1_speed: 6600
          fan2_speed: 6600
          cpu_lower_temp: 80
          cpu_upper_temp: 100
          gpu_lower_temp: 70
          gpu_upper_temp: 100
          ic_lower_temp: 127
          ic_upper_temp: 127
          acceleration: 2
          deceleration: 2
        enable_minifancurve: false
      '';
    in {
      description = "Apply custom maximum hardware fan curve for Lenovo Legion";
      wantedBy = [ "multi-user.target" ];
      after = [ "multi-user.target" ];
      path = with pkgs; [ bash coreutils ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = ''
          ${pkgs.lenovo-legion}/bin/legion_cli lockfancontroller-disable
          ${pkgs.lenovo-legion}/bin/legion_cli fan-unlock-enable || true
          ${pkgs.lenovo-legion}/bin/legion_cli fancurve-write-file-to-hw ${curveFile}
          ${pkgs.lenovo-legion}/bin/legion_cli lockfancontroller-enable
        '';
      };
    };
  };
}

