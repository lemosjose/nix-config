{
  config,
  ...
} :{

imports = [
  ../common
  ../common/tizil
];

programs = {
  zsh = {
    history = {
      path = "/home/lemos/.zsh/history";
    };
  };
};

# Your user packages and home settings
home = {
  stateVersion = "25.05";

  homeDirectory = "/home/lemos";
};


dconf.settings = {
  "org/gnome/desktop/background" = {
    color-shading-type = "solid";
    picture-options = "zoom";
    picture-uri = "${config.home.homeDirectory}/Wallpaper/light.png";
    picture-uri-dark = "${config.home.homeDirectory}/Wallpaper/dark.png";
    primary-color = "#000000000000";
    secondary-color = "#000000000000";
  };
};

}
