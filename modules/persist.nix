{ config, ... }:
{
  environment.persistence."/data" = {
    files = [ "/etc/machine-id" ];
    hideMounts = true;
    directories = [
      "/var/lib/systemd/timers"
      "/var/lib/nixos"
    ];
  };
  boot.initrd.postResumeCommands = lib.mkAfter ''
    delete_subvolume() {
      IFS=$'\n'
      for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
        delete_subvolume "/temp/$i"
      done
      btrfs subvolume delete "$1"
    }
    mkdir /temp
    mount ${config.disko.devices.disk.main.device} /temp
    [[ -e /temp/root ]] && delete_subvolume "/temp/root"
    btrfs subvolume create /temp/root
    umount /temp
  '';
}