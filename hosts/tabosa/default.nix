{
  pkgs,
  inputs,
  ...
}:{
imports = [
  ./hardware-configuration.nix
  ./disko.nix

  ../common/system/global
  ../common/system
  ../common/system/misc/podman.nix
  ../common/system/misc/gnome.nix
  ../common/system/hybridGPU/hybrid.nix
  
  ../common/users/lemos
  ../common/users/Joseph
];

boot.kernelParams = [
  "quiet"
  "splash"
];

networking.networkmanager.wifi.powersave = true; 

networking.hostName = "tabosa";

powerManagement.powertop.enable = true;

hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
};

users.defaultUserShell = pkgs.zsh;

services.logind = {
  powerKey = "suspend";
  powerKeyLongPress = "poweroff";
};

services.zfs.autoSnapshot = {
  enable = true;
  weekly = 4;
};

services.zfs.trim.enable = true;

networking.hostId = "1a2b3c4d";

system.stateVersion = "25.05"; 
}
