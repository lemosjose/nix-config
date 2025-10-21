# This header is crucial. It turns the file into a function
# that receives 'pkgs' and other inputs.
{ pkgs, ... }:

{
  imports = [
    ../common-base.nix
  ];

  # Your user packages and home settings
  home = {
    stateVersion = "25.05";

    homeDirectory = "/home/lemos";

    packages = with pkgs; [
      libreoffice-fresh
      keepassxc
      mupdf
      discord
      calibre
      thunderbird
      kdePackages.okular
      vlc
      ptyxis
      firefox
      pavucontrol
      spotify
      vivaldi
      gimp
      python3Full
      emacs-pgtk
      ghostty
      papers
      gnome-tweaks
    ];
  };
}
