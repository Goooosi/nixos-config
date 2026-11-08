{ ... }:
{
  flake.modules.nixos.audio = { ... }: {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # jack.enable = true;
      extraConfig.pipewire."99-latency"."context.properties" = {
        "default.clock.quantum" = 256;
        "default.clock.min-quantum" = 64;
        "default.clock.max-quantum" = 2048;
      };
    };

    environment.variables = {
      LV2_PATH  = "/run/current-system/sw/lib/lv2:/etc/profiles/per-user/$USER/lib/lv2:$HOME/.lv2";
      VST3_PATH = "/run/current-system/sw/lib/vst3:/etc/profiles/per-user/$USER/lib/vst3:$HOME/.vst3";
    };

    security.pam.loginLimits = [
      { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
      { domain = "@audio"; item = "rtprio";  type = "-"; value = "99"; }
    ];
  };
}
