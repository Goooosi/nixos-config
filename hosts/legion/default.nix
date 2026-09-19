{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    inputs.self.modules.nixos.boot
    inputs.self.modules.nixos.audio
    inputs.self.modules.nixos.game
    inputs.self.modules.nixos.misc
    inputs.self.modules.nixos.network
    inputs.self.modules.nixos.nvidia
    inputs.self.modules.nixos.nixpkgs
    inputs.self.modules.nixos.niri
    inputs.self.modules.nixos.power
    inputs.self.modules.nixos.firmware
    (inputs.self + "/users/users.nix")   
  ];

  networking.hostName = "legion";
  system.stateVersion = "26.05";
}

