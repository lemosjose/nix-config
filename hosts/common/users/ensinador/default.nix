{ config ,
  pkgs,
  inputs, 
  ...
}:let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in{
  
  users.users.ensinador = {
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
      "render"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJIWMX76V24CKUvro/06NX85S3+xmRJOivuZCzeN+oOa Joseph@tabosa"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL44/AmIppQbPyDncByry1SrUzrAi8PeXycLM6vS5kN0 Joseph@tizil"
    ];
    
    hashedPassword = "$y$j9T$S5cs9fpkZ6ZD7e6gQwlv2/$Z0s/rDperza2B6xMAJ3G7mIFKiSQ5K45pqFYQPc1N38";

    

    packages = [pkgs.home-manager]; 
  };

  home-manager.users.ensinador = import ../../../../home/ensinador/${config.networking.hostName}.nix;

}
