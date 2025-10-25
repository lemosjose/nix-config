{
  pkgs,
  ...
}: {
services = {
  xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    enable = true;
  };

  gnome.gnome-keyring.enable = true;

  udev.packages = with pkgs; [ android-udev-rules gnome-settings-daemon];

};

environment.gnome.excludePackages =  with pkgs; [ geary totem gnome-weather gnome-music evince ];

environment.systemPackages = with pkgs; [
  gnomeExtensions.gsconnect
  gnomeExtensions.night-theme-switcher
];


#gsconnect stuff
networking.firewall = rec {
  allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
  allowedUDPPortRanges = allowedTCPPortRanges;
};

}
