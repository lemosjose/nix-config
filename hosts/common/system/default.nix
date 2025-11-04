{
  inputs,
  outputs,
  ...
}:

{
imports = [
  inputs.home-manager.nixosModules.home-manager
];

home-manager.useGlobalPkgs = true;
home-manager.useUserPackages = true;
home-manager.extraSpecialArgs = {
  inherit inputs;
};

#makes the backup suicidal while this things is only getting on my way
home-manager.backupFileExtension = "chicopezao";

nixpkgs = {
  config = {
    allowUnfree = true;
  };
};


#i do not want to get locked 
security.pam.loginLimits = [
  {
    domain = "@wheel";
    item = "nofile";
    type = "soft";
    value = "524288";
  }
  {
    domain = "@wheel";
    item = "nofile";
    type = "hard";
    value = "1048576";
  }
];

nix.settings.experimental-features = ["nix-command" "flakes"];

boot.kernel.sysctl = {"vm.swappiness" = 60; };
}
