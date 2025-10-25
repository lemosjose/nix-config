{
  pkgs,
  ...
}: {

hardware = {
    enableAllFirmware = true;

    firmware = [pkgs.linux-firmware];

    graphics = {
      enable = true;
	    enable32Bit = true;
    };
};

}
