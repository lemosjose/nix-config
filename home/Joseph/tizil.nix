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

  dconf.settings = {
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///${config.home.homeDirectory}/Wallpaper/light.jpg";
      picture-uri-dark = "file://${config.home.homeDirectory}/Wallpaper/dark.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };
  };
}
