{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    inputs.self.modules.nixos.base
    inputs.self.modules.nixos.audio
    inputs.self.modules.nixos.game
    inputs.self.modules.nixos.nvidia
    inputs.self.modules.nixos.firmware
    inputs.self.modules.nixos.legion-fan-curve
    (inputs.self + "/users/users.nix")
  ];
  home-manager.users.zi = { ... }: {
    imports = [
      inputs.self.modules.homeManager.music
      inputs.self.modules.homeManager.flatpak
    ];
  };
  networking.hostName = "legion";
  system.stateVersion = "26.05";
}

