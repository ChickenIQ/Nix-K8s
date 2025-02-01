{
  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/disk/by-diskseq/1";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          name = "ESP";
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
            extraArgs = ["-f"];
            subvolumes = {
              "root" = {
                mountpoint = "/";
                mountOptions = [ "compress=zstd" "noatime" ];
              };

              "nix" = {
                mountpoint = "/nix";
                mountOptions = [ "compress=zstd" "noatime" ];
              };

              "data" = {
                mountpoint = "/data";
                mountOptions = [ "compress=zstd" "noatime" ];
              };
            };
          };
        };
      };
    };
  };
}
