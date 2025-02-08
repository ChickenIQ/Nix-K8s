{
  environment.persistence."/data" = {
    files = ["/etc/machine-id"];
    hideMounts = true;
    directories = [
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
      "/etc/machineconfig"
      "/var/lib/nixos"
      "/var/log"
    ];
  };
}