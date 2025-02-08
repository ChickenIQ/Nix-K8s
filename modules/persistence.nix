{
  environment.persistence."/data" = {
    hideMounts = true;
    files = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/machine-id"
    ];
    directories = [
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
      "/etc/machineconfig"
      "/var/lib/nixos"
      "/var/log"
    ];
  };
}