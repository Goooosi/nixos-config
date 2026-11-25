top@{ inputs, ... }:
let
  user = top.config.flake.meta.username;
in
{
  flake.nixosConfigurations.legion = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; }; # see the note below
    modules = [ top.config.flake.modules.nixos.legion ];
  };

  flake.modules.nixos.legion = {
    imports =
      (with inputs.self.modules.nixos; [
        base
        zi
        audio
        game
        nvidia
        legion-fan-curve
        flatpak
      ])
      ++ [
        ./_legion/hardware-configuration.nix
        inputs.nix-flatpak.nixosModules.nix-flatpak
      ];

    home-manager.users.${user}.imports = [ inputs.self.modules.homeManager.music ];

    services.flatpak = {
      packages = [
        "org.jellyfin.JellyfinDesktop"
        "org.kde.kcolorchooser"
        "fr.handbrake.ghb"
      ];
    };
    # move this into boot.nix and add a contional to use which hosts config
    boot.tmp.useTmpfs = true;
    boot.tmp.tmpfsSize = "25%";
    boot.zswap.maxPoolPercent = 15;
    boot.tmp.cleanOnBoot = true;
    boot.kernel.sysctl = {
      "vm.swappiness" = 15;
    };
    systemd.services.nix-daemon.environment.TMPDIR = "/var/tmp";
    nix.settings.auto-optimise-store = true;
    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = 16 * 1024;
        options = [ "discard=once" ];
      }
    ];
    fileSystems."/".options = [
      "noatime"
      "defaults"
    ];
    system.stateVersion = "26.05";
    networking.hostName = "legion";
  };
}
