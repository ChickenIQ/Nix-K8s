{ cfg, config, ... }:
{
  networking.firewall.allowedTCPPorts = config.services.openssh.ports;
  users.users.root.openssh.authorizedKeys.keys = cfg.authorizedKeys;

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
}