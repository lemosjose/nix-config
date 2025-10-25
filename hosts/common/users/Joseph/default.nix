{ config ,
  pkgs,
  inputs, 
  ...}: {
users.users.Joseph = {
  isNormalUser= true;
  extraGroups = [
    "adbusers"
    "wheel"
    "input"
    "audio"
    "render"
    "polkit"
    "networkmanager"
    "video"
  ];
  
  hashedPassword = "$y$j9T$yYbCRUzf6ju5ExOtuFcjd/$490UtXqCPI3Qci30GwG5vQmtIo0PEZUyuOcJN5TeTAA";

  packages = [pkgs.home-manager]; 
};

home-manager.users.Joseph = import ../../../../home/Joseph/${config.networking.hostName}.nix;

}
