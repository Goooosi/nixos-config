{ lib, ... }:
{
  options.flake.meta = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.flake.meta = {
    username = "zi";
    stateVersion = "26.05";
  };
}
