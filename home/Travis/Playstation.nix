{
  config,
  pkgs,
  inputs,
  ...
} :{

# Your user packages and home settings
home = {
  stateVersion = "25.05";
  
  homeDirectory = "/home/Travis";
};

nixpkgs.config.allowUnfree = true;

home.packages = with pkgs; [
  keepassxc
  papers
  discord
  spotify
  vlc
  firefox
  pavucontrol
];


}
