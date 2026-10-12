{ inputs, ... }:
{
  flake.modules.homeManager.no-noctalia = { pkgs, ... }: {
    imports = [ 
      inputs.mangobar.homeManagerModules.default
    ];
    home.packages  = with pkgs; [
      fuzzel
      eww
      mako
      swayidle
      swaylock-effects
      grim
      slurp
      cliphist
      wayland-pipewire-idle-inhibit
    ];
    services.mangobar = {
      enable = true;
      systemdTarget = "mango.target";
    };
  };
}
