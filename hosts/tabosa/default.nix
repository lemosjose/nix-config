{
  pkgs,
  inputs,
  ...
}:{
imports = [
  ./hardware-configuration.nix
  ./disko.nix
  ./snapshots.nix

  ../common/system/global
  ../common/system
  ../common/system/misc/podman.nix
  ../common/system/misc/gnome.nix
  ../common/system/misc/ollama.nix
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

services.logind.settings.Login = {
  HandlePowerKey = "suspend";
  HandlePowerKeyLongPress = "poweroff";
};

system.stateVersion = "25.05";
}
