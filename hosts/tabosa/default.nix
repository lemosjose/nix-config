{
  pkgs,
  inputs,
  ...
}:{
imports = [
  # Ryzen 7 7735HS (Rembrandt-R) + Radeon 680M iGPU, no discrete GPU.
  # The old Samsung hybrid Intel+NVIDIA PRIME module is retired to
  # backup/tabosa-hybridgpu-nvidia-prime.nix — its hardcoded bus IDs and
  # proprietary driver do not apply to this machine.
  inputs.hardware.nixosModules.common-cpu-amd
  inputs.hardware.nixosModules.common-cpu-amd-pstate
  inputs.hardware.nixosModules.common-gpu-amd
  inputs.hardware.nixosModules.common-pc-laptop
  inputs.hardware.nixosModules.common-pc-laptop-ssd

  ./hardware-configuration.nix
  ./disko.nix

  ../common/system/global
  ../common/system
  ../common/system/misc/podman.nix
  ../common/system/misc/gnome.nix
  ../common/system/misc/ollama.nix

  ../common/users/lemos
  ../common/users/Joseph
];

# Previously came from the retired hybrid.nix; kept so 32-bit GL (Steam,
# wine) keeps working on the iGPU.
hardware.graphics = {
  enable = true;
  enable32Bit = true;
};

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
