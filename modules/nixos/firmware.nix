{ ... }:
{
  flake.modules.nixos.firmware = { pkgs, ... }:
    let
      pinnedPkgs = import (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/c043004d1c6985732bcc1cbc5a9c9aecbbb4e0f0.tar.gz";
        sha256 = "061x1hflyz80rfmzs3vp4kaf29i8qdsw8pasczyyabn7dd7j61pd";      }) { inherit (pkgs) system; };
    in
    {
      hardware.firmware = [ pinnedPkgs.linux-firmware ];
    };
}
