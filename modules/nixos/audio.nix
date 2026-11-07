{ ... }:
{
flake.modules.nixos.audio = { ...}: {
# Enable rtkit for better realtime audio performance
security.rtkit.enable = true;

# Enable PipeWire and its compatibility shims
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  # jack.enable = true;
  
  # WirePlumber is the default session manager for PipeWire
  wireplumber.enable = true;
};
  
  environment.variables = {
    LV2_PATH  = "/run/current-system/sw/lib/lv2:/etc/profiles/per-user/$USER/lib/lv2:$HOME/.lv2";
    VST3_PATH = "/run/current-system/sw/lib/vst3:/etc/profiles/per-user/$USER/lib/vst3:$HOME/.vst3";
  };
  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio";  type = "-"; value = "99"; }
  ];
  # Audio Fixes
  services.pipewire.extraConfig.pipewire."99-realtime" = {
  "context.modules" = [
    {
      name = "libpipewire-module-rt";
      args = {
        "nice.level" = -11;
        "rt.prio" = 88;
        "rt.time.soft" = 200000;
        "rt.time.hard" = 200000;
      };
      flags = [ "ifexists" "nofail" ];
    }
  ];
  "context.properties" = {
    "default.clock.quantum" = 2048;
    "default.clock.min-quantum" = 2048;
    "default.clock.max-quantum" = 2048;
  };
};
};
}
