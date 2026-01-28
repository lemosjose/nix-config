{ config ,
  pkgs,
  inputs, 
  ...
}:
{  
users.users.Travis = {
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
  
hashedPassword = "$y$j9T$9iwPHpxzIbweCKUqR3SK30$p.nfZH0kg3Qnea79Jbdz8m0f5m1MSWjtIviHgZSGl53";

packages = [pkgs.home-manager]; 
};

home-manager.users.Travis = import ../../../../home/Travis/${config.networking.hostName}.nix;

}
