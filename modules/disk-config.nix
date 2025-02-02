{ config, lib, ... }:
{
  disko.devices.disk.main = {
    device = lib.mkDefault "/dev/vda";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        esp = {
          name = "esp";
          size = "1024M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = ["umask=0077"];
          };
        };
        system = {
          size = "100%";
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "root" = {
                mountOptions = [ "noatime" ];
                mountpoint = "/";
              };
              "nix" = {
                mountOptions = [ "noatime" ];
                mountpoint = "/nix";
              };
              "data" = {
                mountOptions = [ "noatime" ];
                mountpoint = "/data";
              };
            };
          };
        };
      };
    };
  };

  fileSystems."/data".neededForBoot = true;
  
  boot.initrd.postResumeCommands = lib.mkAfter ''
    delete_subvolume() {
      IFS=$'\n'
      for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
        delete_subvolume "/temp/$i"
      done
      btrfs subvolume delete "$1"
    }
    mkdir /temp
    mount ${config.fileSystems."/".device} /temp
    [[ -e /temp/root ]] && delete_subvolume "/temp/root"
    btrfs subvolume create /temp/root
    umount /temp
  '';
}
