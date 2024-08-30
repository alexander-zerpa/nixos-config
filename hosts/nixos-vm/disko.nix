{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
	content = {
	  type = "gpt";
	  partitions = {
	    boot = {
	      label = "vm-boot";
	      size = "1M";
	      type = "EF02";
	    };
	    ESP = {
	      label = "vm-esp";
	      size = "512M";
	      type = "EF00";
	      content = {
	        type = "filesystem";
		format = "vfat";
		mountpoint = "/boot";
	      };
            };
	    swap = {
	      label = "vm-swap";
	      size = "16G";
	      content = {
		type = "swap";
		resumeDevice = true;
              };
	    };
	    root = {
	      label = "vm-root";
	      size = "100%";
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
}
