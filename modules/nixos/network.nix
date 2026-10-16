{ ... }:
{
flake.modules.nixos.network = { ... }: {
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  networking.firewall.enable = true;
  networking.nftables.enable = true;
  # networking.firewall.extraInputRules = ''
  #  ip saddr 192.168.1.0/24 tcp dport 53317 accept
  #  ip saddr 192.168.1.0/24 udp dport 53317 accept
  #'';
};
}
