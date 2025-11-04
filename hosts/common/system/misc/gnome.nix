{
  pkgs,
  ...
}: {
services = {
  displayManager.gdm.enable = true;
  displayManager.autoLogin = {
    enable = true;
    user = "Joseph"; 
  };
  desktopManager.gnome.enable = true;
  
  #starting to prepare for 25.11, it's coming! 
  gnome.core-apps.enable = false;

  gnome.gnome-keyring.enable = true;

  udev.packages = with pkgs; [gnome-settings-daemon];

};

environment.gnome.excludePackages =  with pkgs; [ geary totem gnome-weather gnome-music evince ];

environment.systemPackages = with pkgs; [
  gnomeExtensions.gsconnect
  gnomeExtensions.appindicator
  gnomeExtensions.clipboard-indicator
  nautilus
];


#gsconnect stuff
networking.firewall = rec {
  allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
  allowedUDPPortRanges = allowedTCPPortRanges;
};
}
