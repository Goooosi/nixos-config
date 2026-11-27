top@{ inputs, ... }:
{
  flake.modules.nixos.shell =
    { pkgs, ... }:
    {
      home-manager.sharedModules = [ inputs.self.modules.homeManager.zsh ];
      programs.zsh.enable = true;
      users.defaultUserShell = pkgs.zsh;
    };

  flake.modules.homeManager.zsh =
    { pkgs, ... }:
    let
      repo = top.config.flake.meta.repoPath;
    in
    {
      programs.zsh = {
        enable = true;

        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
          rebuild = "sudo nixos-rebuild switch --flake ${repo}#\$HOST";
          fanSpeed = "nix-shell -p lm_sensors --run 'while true; do echo \"\$(date +%T) \$(sensors | grep Tctl) | fans: \$(cat /sys/class/hwmon/hwmon*/fan*_input | tr \"\\n\" \" \")\"; sleep 1; done'";
          computerActivateLarp = "nix-shell -p cmatrix --run cmatrix";
          deleteGeneration = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations $(sudo nix-env --profile /nix/var/nix/profiles/system --list-generations | head -n -10 | awk '{print $1}')";
          listGenerations = "nixos-rebuild list-generations";
        };

        initContent = ''
                          bindkey -v
                  	      export ZLE_RPROMPT_INDENT=0
                            if [[ -o interactive ]] && [[ -z "$FASTFETCH_RAN" ]]; then
            export FASTFETCH_RAN=1
            fastfetch
          fi
        '';
      };

      programs.starship.enable = true;
    };
}
