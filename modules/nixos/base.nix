{ inputs, ... }:
{
  flake.modules.nixos.base = { ... }: {
    users.users.root.hashedPassword = "!";
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
      home-manager
    ];
    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  };
}
