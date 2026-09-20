{ ... }:
{
  flake.modules.homeManager.zsh = { pkgs, ... }: {
    home.packages = with pkgs; [ fastfetch pokeget-rs ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#\$HOST";
      };

      initContent = ''
        bindkey -v
        export EDITOR=nvim
        export VISUAL=nvim
	      export ZLE_RPROMPT_INDENT=0
        pokeget umbreon --hide-name | fastfetch --logo-padding-top 4 --logo-padding-left 0 --logo-padding-right 1 --file-raw -
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
