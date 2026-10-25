{ inputs, ... }:
{
  flake.modules.homeManager.no-noctalia = { pkgs, ... }: {
    programs.waybar = {
      enable = true;
      package = inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
      doCheck = false;
      mesonFlags =
        (builtins.filter (f: !(pkgs.lib.hasPrefix "-Dtests=" f)) (old.mesonFlags or []))
        ++ [ "-Dtests=disabled" ];
      });
    };
    home.packages  = with pkgs; [
      inputs.wayfreeze.packages.${pkgs.system}.wayfreeze
      fuzzel
      swayosd
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
