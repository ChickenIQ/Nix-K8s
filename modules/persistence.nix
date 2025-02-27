{
  environment.persistence."/data" = {
    hideMounts = true;
    files = [
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/machine-id"
    ];
    directories = [
      "/etc/machineconfig"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
      "/var/lib/nixos"
      "/var/log"
    ];
  };
}