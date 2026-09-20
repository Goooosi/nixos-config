{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.self.modules.nixos.base
    (inputs.self + "/users/users.nix")
  ];
  networking.hostName="acer";
  system.stateVersion = "26.05";
}
