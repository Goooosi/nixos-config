{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.self.modules.nixos.base
    (inputs.self + "/users/user.nix")
  ];
  networking.hostname="acer";
  system.stateVersion = "26.05";
}
