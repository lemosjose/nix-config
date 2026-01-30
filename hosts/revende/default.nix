{
  pkgs,
  inputs,
  ...
}:{
imports = [
  ./hardware-configuration.nix
  ./disko.nix
  ./pkgs.nix

  ../common/system/misc/podman.nix
  ../common/system
  ../common/system/global/boot.nix
  ../common/users/ensinador
  
  ../servers
  ../servers/media
  ../servers/sparrow
];

boot.kernelParams = [
  "quiet"
  "splash"
];

nixpkgs.config.packageOverrides = pkgs: {
  intel-vaapi-driver = pkgs.intel-vaapi-driver.override {
    enableHybridCodec = true;
  };
};

systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "i965";

environment.sessionVariables = { LIBVA_DRIVER_NAME = "i965";} ;

hardware.graphics.extraPackages = with pkgs; [
  intel-vaapi-driver
];

networking.hostName = "revende";

networking.defaultGateway = "192.168.1.1";

networking.nameservers = [ "1.1.1.1" "8.8.8.8" ]; 

networking.interfaces.enp8s0.ipv4.addresses = [ {
  address = "192.168.1.212"; 
  prefixLength = 24;
} ];

powerManagement.powertop.enable = true;

users.users.root.openssh.authorizedKeys.keys = [
  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJIWMX76V24CKUvro/06NX85S3+xmRJOivuZCzeN+oOa Joseph@tabosa"
  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL44/AmIppQbPyDncByry1SrUzrAi8PeXycLM6vS5kN0 Joseph@tizil"
];

systemd.targets.sleep.enable = false;
systemd.targets.suspend.enable = false;
systemd.targets.hibernate.enable = false;
systemd.targets.hybrid-sleep.enable = false;

programs.zsh.enable = true; 

users.defaultUserShell = pkgs.zsh;

system.stateVersion = "25.05"; 
}
