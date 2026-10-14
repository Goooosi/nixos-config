{ inputs, ... }:
{
  flake.modules.homeManager.no-noctalia = { pkgs, ... }: {
    programs.waybar.enable = true;
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
      swappy
    ];
  };
}
