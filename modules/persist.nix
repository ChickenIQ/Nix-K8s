{
  environment.persistence."/data" = {
    files = [ "/etc/machine-id" ];
    hideMounts = true;
    directories = [
      "/var/lib/systemd/timers"
      "/var/lib/nixos"
    ];
  };
}