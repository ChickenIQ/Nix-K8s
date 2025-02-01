{ cfg, ... }:
{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  networking.firewall.allowedTCPPorts = [22];

  users.users.root.openssh.authorizedKeys.keys = cfg.authorizedKeys;

  boot.loader = {
    timeout = 0;
    grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
  };
}