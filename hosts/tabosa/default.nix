{
  pkgs,
  inputs,
  ...
}:{
imports = [
  ./hardware-configuration.nix

  ../common/system/global
  ../common/system

  
  ../common/system/misc/podman.nix
  ../common/system/misc/cosmic.nix

  
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

system.stateVersion = "25.05"; 
}
