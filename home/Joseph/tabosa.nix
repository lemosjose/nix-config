{
  pkgs,
  config,
  inputs,
  ...
}:
{
imports = [
  ../common

  ../common/tabosa/plasma.nix
];

programs = {
  zsh = {
    history = {
      path = "/home/Joseph/.zsh/history";
    };
  };
};

# Your user packages and home settings
home = {
  stateVersion = "25.05";

  packages = with pkgs; [
    google-chrome
    postman
    awscli2
  ];

  homeDirectory = "/home/Joseph";
};
}
