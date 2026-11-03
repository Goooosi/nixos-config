{ inputs, ... }:
{
  flake.modules.homeManager.no-noctalia = { pkgs, ... }: {
    programs.waybar = {
      enable = true;
      package = inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
      doCheck = false;
    
      buildInputs = (old.buildInputs or []) ++ [ pkgs.libcava ];

      mesonFlags =
        (builtins.filter (f: !(pkgs.lib.hasPrefix "-Dtests=" f)) (old.mesonFlags or []))
        ++ [ 
          "-Dtests=disabled"
          "-Dcava=enabled" # 2. Explicitly force CAVA module compilation
          ];
        });
    };
    programs.rofi.enable = true;
    home.packages  = with pkgs; [
      inputs.wayfreeze.packages.${pkgs.stdenv.hostPlatform.system}.wayfreeze
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
      impala
      wiremix
      pamixer
      bluetui
    ];
  };
}
