{ pkgs, ... }:

{
flake.modules.nixos.nixpkgs = { pkgs,  ... }: {
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = with pkgs; [
    brightnessctl
    neovim
    kitty
  ];
};
}
