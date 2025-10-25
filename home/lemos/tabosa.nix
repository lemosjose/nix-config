{
  imports = [
    ../common
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
}
