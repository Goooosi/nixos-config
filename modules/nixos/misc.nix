{ pkgs, ... }:
{
flake.modules.nixos.misc= { pkgs, ... }: {
  #zsh shell
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
   
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.gvfs.enable = true;
  services.flatpak.enable = true;

  #theme thingy
  programs.dconf.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-gnome ];
    config.common.default = [ "gtk" ];
  };
  #greetd
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd niri-session";
      user = "greeter";
    };
  };
  #app image
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  programs.appimage.package =
    pkgs.appimage-run.override {
      extraPkgs = pkgs: [
        pkgs.python312
      ];
    };
  swapDevices = [ {
  device = "/var/lib/swapfile";
  size = 16 * 1024;
    }
  ];
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };
};
}
