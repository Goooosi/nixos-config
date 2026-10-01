{ lib, ... }:
{
  flake.modules.nixos.acer-battery = { config, lib, pkgs, ... }: 
  let
    cfg = config.services.acer-battery;
    
    acer-wmi-battery = config.boot.kernelPackages.callPackage ({ stdenv, fetchFromGitHub, kernel }: stdenv.mkDerivation rec {
      name = "acer-wmi-battery-${version}-${kernel.version}";
      version = "unstable-2026";

      src = fetchFromGitHub {
        owner = "frederik-h";
        repo = "acer-wmi-battery";
        rev = "main";
        hash = "sha256-CyKRpE3cnhEIFHc4Hal2PQUW7cd5k8+55S4QdSqGvNI=";
      };

      hardeningDisable = [ "pic" "format" ];
      nativeBuildInputs = kernel.moduleBuildDependencies; 
      buildPhase = ''
        runHook preBuild
        make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build M=$(pwd) modules
        runHook postBuild
      '';

      installPhase = ''
        runHook preInstall
        mkdir -p $out/lib/modules/${kernel.modDirVersion}/misc
        cp acer-wmi-battery.ko $out/lib/modules/${kernel.modDirVersion}/misc/
        runHook postInstall
      '';
    }) {};
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

