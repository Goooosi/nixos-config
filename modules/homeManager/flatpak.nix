{ inputs, ... }:
{
  flake.modules.homeManager.flatpak = { pkgs, ... }: {
    imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

    services.flatpak = {
      enable = true;
      remotes = [{
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }];
      packages = [
        "org.vinegarhq.Sober"
	      "org.jellyfin.JellyfinDesktop"
      ];

      overrides = {
        "org.vinegarhq.Sober" = {
	  Enviornment = {
	    "__NV_PRIME_RENDER_OFFLOAD" = "1";
            "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
            "__VK_LAYER_NV_optimus" = "NVIDIA_only";
	  };
	};
      };
      uninstallUnmanaged = true;
    };
  };
}
