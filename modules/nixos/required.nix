{ ... }:
{
  flake.modules.nixos.required = { ... }: {
    nixpkgs.config.allowUnfree = true;

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    nix.optimise.automatic = true;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
