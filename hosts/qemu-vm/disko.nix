{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
	content = {
	  type = "gpt";
	  partitions = {
	    boot = {
	      start = "1M";
	      size = "512M";
	      type = "EF00";
	      content = {
	        type = "filesystem";
		format = "vfat";
		mountpoint = "/boot";
	      };
            };
	    swap = {
	      size = "16G";
	      content = {
		type = "swap";
		resumeDevice = true;
              };
	    };
	    root = {
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
