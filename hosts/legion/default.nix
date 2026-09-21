{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    inputs.self.modules.nixos.base
    inputs.self.modules.nixos.audio
    inputs.self.modules.nixos.game
    inputs.self.modules.nixos.nvidia
    inputs.self.modules.nixos.firmware
    inputs.self.modules.nixos.legion-fan-curve
    (inputs.self + "/users/users.nix")
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];
  # 2. Configure Flatpak globally for the system
  services.flatpak = {
    enable = true;
    remotes = [{
      name = "flathub";
      location = "https://flathub.org";
    }];
    
    packages = [
      "org.vinegarhq.Sober"
      "org.jellyfin.JellyfinDesktop"
    ];

    overrides = {
      "org.vinegarhq.Sober" = {
        Environment = {
          "__NV_PRIME_RENDER_OFFLOAD" = "1";
          "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
          "__VK_LAYER_NV_optimus" = "NVIDIA_only";
        };
      };
    };
    uninstallUnmanaged = true;
  };

  networking.hostName = "legion";
  system.stateVersion = "26.05";
}

