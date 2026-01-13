{
  pkgs,
  config,
  ...
}:{
imports = [
  ../common
  ../common/tizil
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

  homeDirectory = "/home/Joseph";

  packages = with pkgs; [
    google-chrome
    postman
  ];
};


}
