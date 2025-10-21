{ pkgs, ... }:

{
  imports = [
    ../common-base.nix
  ];

  programs = {
    vscode = { 
      enable = true; 
	    package = pkgs.vscode.fhsWithPackages (ps: with ps; [ rustup zlib pkg-config ]);
    };
  };

  
  home = {
    stateVersion = "25.05";

    homeDirectory = "/home/Joseph";
      
    packages = with pkgs; [
      libreoffice-fresh
      keepassxc
      discord
      google-chrome
      thunderbird
      kdePackages.okular
      vlc
      zed-editor
      ptyxis
      postman
      firefox
      vivaldi
      pavucontrol
      python3Full
      emacs-pgtk
      ghostty
      papers
      gnome-tweaks
    ];
  };
}
  
