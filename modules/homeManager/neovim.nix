{ ... }:
{
  flake.modules.homeManager.neovim = { pkgs, ... }: {
    home.packages = with pkgs; [
      neovim
      wl-clipboard
      ripgrep
      fd
      nodejs
      git
    ];

    home.file.".config/nvim" = {
      source = ../../dotfiles/nvim;
      recursive = true;
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
