{
  pkgs,
  config,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in  {
users.users.lemos = {
      isNormalUser = true;
      extraGroups = ifTheyExist [
        "adbusers"
        "wheel"
        "input"
        "audio"
        "render"
        "polkit"
        "podman"
        "i2c"
        "networkmanager"
        "video"
      ];
      hashedPassword = "$y$j9T$ILvyeB3rSFT7yiMgx6xBh/$O3qkgsba6AcXEwtzfu2v9aWgVF.aw7F9SBoa/Lciji6";
      packages = [pkgs.home-manager];
};

home-manager.users.lemos = import ../../../../home/lemos/${config.networking.hostName}.nix;

}
