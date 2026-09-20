{ ... }:
{
flake.modules.nixos.fonts = { pkgs, ... }: {
  fonts.packages = with pkgs; [
    maple-mono.truetype
    maple-mono.NF-unhinted
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Maple Mono NF" ];
      sansSerif = [ "Noto Sans" ];
      serif     = [ "Noto Serif" ];
      emoji     = [ "Noto Color Emoji" ];
    };
  };
  fonts.fontDir.enable = true; 
};
}
