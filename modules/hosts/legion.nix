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
      ])
      ++ [
        ./_legion/hardware-configuration.nix
        inputs.nix-flatpak.nixosModules.nix-flatpak
      ];

    home-manager.users.${user}.imports = [ inputs.self.modules.homeManager.music ];

    services.flatpak = {
      enable = true;
      remotes = [
        {
          name = "flathub";
          location = "https://flathub.org";
        }
      ];
      packages = [
        "org.vinegarhq.Sober"
        "org.jellyfin.JellyfinDesktop"
        "org.kde.kcolorchooser"
        "fr.handbrake.ghb"
      ];
      overrides."org.vinegarhq.Sober".Environment = {
        "__NV_PRIME_RENDER_OFFLOAD" = "1";
        "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
        "__VK_LAYER_NV_optimus" = "NVIDIA_only";
        "VK_DRIVER_FILES" = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/nvidia_icd.i686.json";
      };
      uninstallUnmanaged = true;
    };

    networking.hostName = "legion";
    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    system.stateVersion = top.config.flake.meta.stateVersion;
  };
}
