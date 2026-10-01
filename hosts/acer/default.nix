{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.self.modules.nixos.base
    inputs.self.modules.nixos.acer-battery
    (inputs.self + "/users/users.nix")
  ];

  services.acer-battery.enable = true;
  networking.hostName="acer";
  system.stateVersion = "26.05";
}
