{ ... }:
{
  flake.modules.homeManager.zsh = { pkgs, ... }: {
    home.packages = with pkgs; [ fastfetch ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#\$HOST";
        fanSpeed = "nix-shell -p lm_sensors --run 'while true; do echo \"\$(date +%T) \$(sensors | grep Tctl) | fans: \$(cat /sys/class/hwmon/hwmon*/fan*_input | tr \"\\n\" \" \")\"; sleep 1; done'";
        computerActivateLarp = "nix-shell -p cmatrix --run cmatrix";
        deleteGeneration = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations $(sudo nix-env --profile /nix/var/nix/profiles/system --list-generations | head -n -10 | awk '{print $1}')";
        listGenerations = "nixos-rebuild list-generations";
      };

      initContent = ''
        bindkey -v
        export EDITOR=nvim
        export VISUAL=nvim
	      export ZLE_RPROMPT_INDENT=0
        fastfetch 
        export LANG=en_US.UTF-8
	      export LC_ALL=en_US.UTF-8
      '';
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };
    home.file.".config/starship.toml".source = ../../dotfiles/starship/starship.toml;
  };
}
