{ ... }:
{
  flake.modules.nixos.wofi-fix = { pkgs, ... }:
    let
      chooser = pkgs.writeShellScript "xdpw-chooser" ''
        cache="$XDG_RUNTIME_DIR/xdpw-chooser-last"
        cancel="$XDG_RUNTIME_DIR/xdpw-chooser-cancel"
        now=$(${pkgs.coreutils}/bin/date +%s)

        fresh() { [ -f "$1" ] && [ $(( now - $(${pkgs.coreutils}/bin/stat -c %Y "$1") )) -lt "$2" ]; }

        input=$(${pkgs.coreutils}/bin/cat)

        fresh "$cancel" 5 && exit 0
        fresh "$cache" 15 && { ${pkgs.coreutils}/bin/cat "$cache"; exit 0; }

        choice=$(printf '%s\n' "$input" | ${pkgs.wofi}/bin/wofi --show dmenu --prompt "Select what to share")

        if [ -n "$choice" ]; then
          printf '%s\n' "$choice" > "$cache"
          printf '%s\n' "$choice"
        else
          touch "$cancel"
        fi
      '';
    in
    {
      xdg.portal.wlr.settings.screencast = {
        chooser_type = "dmenu";
        chooser_cmd = "${chooser}";
        force_mod_linear = 1;
      };
    };
}
