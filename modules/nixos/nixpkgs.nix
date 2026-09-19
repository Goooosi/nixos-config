{ pkgs, ... }:

{
flake.modules.nixos.nixpkgs = { pkgs,  inputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
};
}
