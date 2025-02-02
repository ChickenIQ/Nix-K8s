{
  environment.persistence."/data" = {
    files = ["/etc/machine-id"];
    hideMounts = true;
    directories = [
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
      "/var/lib/nixos"
      "/var/log"
    ];
  };
}