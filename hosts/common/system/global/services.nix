{
  pkgs,
  ...
}: {
services = {

  avahi.enable = true; 
  
  udev = {
    enable = true; 
	  packages = with pkgs; [ android-udev-rules gnome-settings-daemon];
  };

  gvfs.enable = true; 

  udisks2.enable = true; 

  tumbler.enable = true;

  devmon.enable = true;

  flatpak.enable = true;

  pipewire = {
    enable = true;
    wireplumber.enable = true; 

	  alsa.enable = true; 
	  alsa.support32Bit = true; 
	  pulse.enable = true;
  };
  
};

security = {
  polkit.enable = true;
  rtkit.enable = true;
};

}
