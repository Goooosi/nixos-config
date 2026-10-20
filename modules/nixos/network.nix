{ ... }:
{
flake.modules.nixos.network = { config, ... }: {
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  networking.nftables.enable = true;
  # networking.firewall.extraInputRules = ''
  #  ip saddr 192.168.1.0/24 tcp dport 53317 accept
  #  ip saddr 192.168.1.0/24 udp dport 53317 accept
  #'';
  services.tailscale.enable = true;
  networking.firewall = {
    enable = true;

    trustedInterfaces = [ config.services.tailscale.interfaceName ];

    allowedUDPPorts = [ config.services.tailscale.port ];
  };


  systemd.services.tailscaled.serviceConfig.Environment = [ 
    "TS_DEBUG_FIREWALL_MODE=nftables" 
  ];

  systemd.network.wait-online.enable = false; 
  boot.initrd.systemd.network.wait-online.enable = false;};
}
