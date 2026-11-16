{ ... }:
{
  flake.modules.homeManager.neovim = { pkgs, ... }: {
    home.packages = with pkgs; [
      kitty
      neovim
      wl-clipboard
      ripgrep
      fd
      nodejs
      git
      typescript-language-server  
      pyright                                      
      nil                                         
      lua-language-server
      alejandra
      tree-sitter
      gh
      gcc
    ];
    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
