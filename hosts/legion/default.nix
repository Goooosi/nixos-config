{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    inputs.self.modules.nixos.base
    inputs.self.modules.nixos.audio
    inputs.self.modules.nixos.game
    inputs.self.modules.nixos.nvidia
    # broken on kernel version 7.2.11 and broken on lts????
    inputs.self.modules.nixos.legion-fan-curve
    (inputs.self + "/users/users.nix")
    inputs.nix-flatpak.nixosModules.nix-flatpak
    # inputs.self.modules.nixos.printing
  ];
  home-manager.users.zi = {
    imports = [
      inputs.self.modules.homeManager.music
    ];
  };
  services.flatpak = {
    enable = true;
    remotes = [{
      name = "flathub";
      location = "https://flathub.org";
    }];
    
    packages = [
      "org.vinegarhq.Sober"
      "org.jellyfin.JellyfinDesktop"
      "org.kde.kcolorchooser"
    ];

    overrides = {
      "org.vinegarhq.Sober" = {
        Environment = {
          "__NV_PRIME_RENDER_OFFLOAD" = "1";
          "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
          "__VK_LAYER_NV_optimus" = "NVIDIA_only";
          "VK_DRIVER_FILES" = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/nvidia_icd.i686.json";
        };
      };
    };
    uninstallUnmanaged = true;
  };

  networking.hostName = "legion";
  system.stateVersion = "26.05";
}

