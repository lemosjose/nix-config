{ config ,
  pkgs,
  inputs, 
  ...}:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in{
users.users.Joseph = {
  isNormalUser= true;
  extraGroups = ifTheyExist [
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
