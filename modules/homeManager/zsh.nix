{ ... }:
{
  flake.modules.homeManager.shell = { pkgs, ... }: {
    home.packages = [ pkgs.fastfetch ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      };

      initContent = ''
        bindkey -v
        export EDITOR=nvim
        export VISUAL=nvim
        fastfetch
      '';
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };
    home.file.".config/starship.toml".source = ../../dotfiles/starship/starship.toml;
  };
}
