{ inputs, ... }:
{
  flake.modules.homeManager.no-noctalia = { pkgs, ... }: {
    programs.waybar.enable = true;
    home.packages = with pkgs; [
      inputs.wayfreeze.packages.${pkgs.stdenv.hostPlatform.system}.wayfreeze
      swayosd
      mako
      swayidle
      swaylock-effects
      grim
      slurp
      cliphist
      wayland-pipewire-idle-inhibit
      swappy
      impala
      wiremix
      pamixer
      bluetui
      tofi
    ];
  };
}
