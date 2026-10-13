{ ... }:
{
  flake.modules.nixos.fuzzel-fix = { pkgs, ... }:
    let
      chooser = pkgs.writeShellScript "xdpw-chooser" ''
        cache="$XDG_RUNTIME_DIR/xdpw-chooser-last"
        cancel="$XDG_RUNTIME_DIR/xdpw-chooser-cancel"
        now=$(${pkgs.coreutils}/bin/date +%s)

        fresh() { [ -f "$1" ] && [ $(( now - $(${pkgs.coreutils}/bin/stat -c %Y "$1") )) -lt "$2" ]; }

        input=$(${pkgs.coreutils}/bin/cat)

        fresh "$cancel" 5 && exit 0
        fresh "$cache" 15 && { ${pkgs.coreutils}/bin/cat "$cache"; exit 0; }
        
        ${pkgs.fuzzel}/bin/fuzzel -d --prompt "Select what to share " --keyboard-focus=on-demand --no-exit-on-keyboard-focus-loss < <(printf '%s\n' "$input") > "$XDG_RUNTIME_DIR/xdpw-fuzzel-choice" &
        FUZZEL_PID=$!

        ${pkgs.slurp}/bin/slurp -p -b 00000000 >/dev/null 2>&1 &
        SLURP_PID=$!

        wait -n

        kill $SLURP_PID 2>/dev/null
        kill $FUZZEL_PID 2>/dev/null
        wait $FUZZEL_PID 2>/dev/null

        choice=$(cat "$XDG_RUNTIME_DIR/xdpw-fuzzel-choice" 2>/dev/null)
        rm -f "$XDG_RUNTIME_DIR/xdpw-fuzzel-choice"
        # -------------------------------------

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

