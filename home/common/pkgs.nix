{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
      keepassxc
      mupdf
      discord
      calibre
      kdePackages.okular
      vlc
      pavucontrol
      spotify
      vivaldi
      python3Full
      emacs-pgtk
      ghostty
      papers
      gnome-tweaks
  ]; 
}
