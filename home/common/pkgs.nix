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
  emacs-pgtk
  ghostty
  papers
  zotero
  zeal
]; 
}
