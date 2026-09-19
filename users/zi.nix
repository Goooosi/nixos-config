{ inputs, pkgs, ... }:

{
  # Raw Home Manager user variables exposed natively at the top level
  home.username = "zi";
  home.homeDirectory = "/home/zi";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  imports = [
    inputs.self.modules.homeManager.desktop
    inputs.self.modules.homeManager.dotfiles
    inputs.self.modules.homeManager.zsh
    inputs.self.modules.homeManager.packages
    inputs.self.modules.homeManager.neovim
  ];
}


