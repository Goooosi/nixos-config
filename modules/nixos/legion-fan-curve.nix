{ ... }:
{
  flake.modules.nixos.legion-fan-curve = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.lenovo-legion ];
    boot.kernelModules = [ "lenovo-legion" ];
    boot.extraModulePackages = with pkgs.linuxPackages; [ lenovo-legion-module ];

    systemd.services.lenovo-legion-fancurve = let
      curveFile = pkgs.writeText "fan-curve.conf" ''
        name: "Capped 4400 NixOS Curve"
        entries:
        - fan1_speed: 0
          fan2_speed: 0
          cpu_lower_temp: 0
          cpu_upper_temp: 50
          gpu_lower_temp: 0
          gpu_upper_temp: 50
          ic_lower_temp: 0
          ic_upper_temp: 45
          acceleration: 2
          deceleration: 2
        - fan1_speed: 1800
          fan2_speed: 1800
          cpu_lower_temp: 47
          cpu_upper_temp: 57
          gpu_lower_temp: 47
          gpu_upper_temp: 55
          ic_lower_temp: 42
          ic_upper_temp: 127
          acceleration: 2
          deceleration: 2
        - fan1_speed: 2200
          fan2_speed: 2200
          cpu_lower_temp: 54
          cpu_upper_temp: 62
          gpu_lower_temp: 52
          gpu_upper_temp: 60
          ic_lower_temp: 127
          ic_upper_temp: 127
          acceleration: 2
          deceleration: 2
        - fan1_speed: 2600
          fan2_speed: 2600
          cpu_lower_temp: 60
          cpu_upper_temp: 67
          gpu_lower_temp: 57
          gpu_upper_temp: 64
          ic_lower_temp: 127
          ic_upper_temp: 127
          acceleration: 2
          deceleration: 2
        - fan1_speed: 3000
          fan2_speed: 3000
          cpu_lower_temp: 65
          cpu_upper_temp: 72
          gpu_lower_temp: 61
          gpu_upper_temp: 68
          ic_lower_temp: 127
          ic_upper_temp: 127
          acceleration: 2
          deceleration: 2
        - fan1_speed: 3400
          fan2_speed: 3400
          cpu_lower_temp: 70
          cpu_upper_temp: 76
          gpu_lower_temp: 65
          gpu_upper_temp: 72
          ic_lower_temp: 127
          ic_upper_temp: 127
          acceleration: 2
          deceleration: 2
        - fan1_speed: 3800
          fan2_speed: 3800
          cpu_lower_temp: 74
          cpu_upper_temp: 80
          gpu_lower_temp: 69
          gpu_upper_temp: 76
          ic_lower_temp: 127
          ic_upper_temp: 127
          acceleration: 2
          deceleration: 2
        - fan1_speed: 4100
          fan2_speed: 4100
          cpu_lower_temp: 78
          cpu_upper_temp: 84
          gpu_lower_temp: 73
          gpu_upper_temp: 80
          ic_lower_temp: 127
          ic_upper_temp: 127
          acceleration: 2
          deceleration: 2
        - fan1_speed: 4400
          fan2_speed: 4400
          cpu_lower_temp: 82
          cpu_upper_temp: 90
          gpu_lower_temp: 77
          gpu_upper_temp: 84
          ic_lower_temp: 127
          ic_upper_temp: 127
          acceleration: 2
          deceleration: 2
        - fan1_speed: 4400
          fan2_speed: 4400
          cpu_lower_temp: 88
          cpu_upper_temp: 100
          gpu_lower_temp: 82
          gpu_upper_temp: 100
          ic_lower_temp: 127
          ic_upper_temp: 127
          acceleration: 2
          deceleration: 2
        enable_minifancurve: false
      '';
    in {
      description = "Apply custom hardware fan curve for Lenovo Legion";
      wantedBy = [ "multi-user.target" ];
      after = [ "basic.target" ];
      path = with pkgs; [ bash coreutils ];
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
