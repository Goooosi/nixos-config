{ inputs, ... }:
{
  flake.modules.nixos.base = {
    imports = with inputs.self.modules.nixos; [
      boot 
      fonts 
      network 
      nixpkgs 
      misc 
      niri 
      power 
      qylock
      hardware
      noctalia-cache 
    ];
  };
}
