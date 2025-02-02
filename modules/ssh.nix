{ cfg, config, ... }:
{
  networking.firewall.allowedTCPPorts = config.services.openssh.ports;
  users.users.root.openssh.authorizedKeys.keys = cfg.authorizedKeys;

  services.openssh = {
    enable = true;
    hostKeys = [
      { path = "/data/etc/ssh/ssh_host_rsa_key"; type = "rsa"; bits = 4096; }
      { path = "/data/etc/ssh/ssh_host_ed25519_key"; type = "ed25519"; }
    ];
    settings.PasswordAuthentication = false;
  };
}