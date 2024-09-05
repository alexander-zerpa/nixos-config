{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              label = "vm-boot";
              size = "1M";
              type = "EF02";
            };
            ESP = {
              label = "esp";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            swap = {
              label = "swap";
              size = "4G";
              content = {
                type = "luks";
                name = "cryptswap";
                content = {
                  type = "swap";
                  resumeDevice = true;
                };
              };
            };
            root = {
              label = "root";
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                settings.allowDiscards = true;
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
    };
  };
}
