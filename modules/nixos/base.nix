{ inputs, ... }:
{
  flake.modules.nixos.base = { self, ... }: {
    imports = with inputs.self.modules.nixos; [
      boot 
      fonts 
      network 
      required 
      misc 
      wm 
      power 
      qylock
      hardware
      noctalia-cache
      fuzzel-fix
    ];
    system.configurationRevision = self.rev or self.dirtyRev or null;
  };
}
