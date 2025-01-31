{
  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/vda";
    content = {
      type = "gpt";
      partitions = {
        boot = {
          priority = 1;
          name = "ESP";
          start = "1M";
          end = "1024M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };

        system = {
          size = "100%";
          content = {
            type = "btrfs";
            extraArgs = ["-f"];
            subvolumes = {
              "root" = {
                mountOptions = [ "compress=zstd" "noatime" ];
                mountpoint = "/";
              };

              "nix" = {
                mountOptions = [ "compress=zstd" "noatime" ];
                mountpoint = "/nix";
              };

              "data" = {
                mountOptions = [ "compress=zstd" "noatime" ];
                mountpoint = "/data";
              };
            };
          };
        };
      };
    };
  };
  };
