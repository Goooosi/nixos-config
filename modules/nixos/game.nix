{ inputs, ... }:
{
  flake.modules.nixos.game = { ... }: {
    imports = [ inputs.self.modules.nixos.flatpak ];
    programs.steam.enable = true;
    services.flatpak.packages = [ "org.vinegarhq.Sober" ];
    services.flatpak.overrides."org.vinegarhq.Sober".Environment = {
      "__NV_PRIME_RENDER_OFFLOAD" = "1";
      "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
      "__VK_LAYER_NV_optimus" = "NVIDIA_only";
      "VK_DRIVER_FILES" =
        "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/nvidia_icd.i686.json";
    };
  };
}
