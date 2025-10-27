{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
      keepassxc
    #do not remove, it works inside emacs 
      mupdf
      discord
      calibre
      vlc
      pavucontrol
      spotify
      vivaldi
      emacs-pgtk
      ghostty
      papers
  ]; 
}
