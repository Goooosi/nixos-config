{ inputs, ... }:
{
  flake.modules.nixos.base = { ... }: {
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
    ];
    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  };
}
