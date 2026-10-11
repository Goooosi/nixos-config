{ inputs, ... }:
{
  flake.modules.nixos.base = {
    imports = with inputs.self.modules.nixos; [
      boot 
      fonts 
      network 
      nixpkgs 
      misc 
      wm 
      power 
      qylock
      hardware
      noctalia-cache
      wofi-fix
    ];
  };
}
