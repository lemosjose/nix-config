{
  pkgs,
  inputs,
  ...
}: {
imports = [
  inputs.hardware.nixosModules.common-cpu-amd
  inputs.hardware.nixosModules.common-gpu-amd
  inputs.hardware.nixosModules.common-pc-ssd

  ./hardware-configuration.nix

  ../common/system/global

  ../common/system

  ../common/system/misc/ollama.nix
  ../common/system/misc/podman.nix
  ../common/system/misc/gnome.nix 

  ../common/users/lemos
  ../common/users/Joseph

  ./gaming
  
];

services.xserver.videoDrivers = [ "amdgpu" ];

boot = {
  kernelParams = [
	  "amdgpu.ppfeaturemask=0xffffffff"
	  "amdgpu.gpu_recovery=1"
	  "quiet"
    "pcie_aspm=off"
	  "splash"
  ];

  initrd.kernelModules = [ "amdgpu" ];
};

networking.networkmanager.wifi.powersave = false; 

virtualisation.waydroid.enable = true;

users.defaultUserShell = pkgs.zsh;

networking.hostName = "tizil";

environment.systemPackages = with pkgs; [ aider-chat-full ];

system.stateVersion = "25.05";
}
