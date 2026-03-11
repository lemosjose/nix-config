{
  pkgs,
  ...
}: {
home.packages = with pkgs; [
  keepassxc
  #do not remove, it works inside emacs 
  mupdf
  discord
  vlc
  pavucontrol
  emacs-pgtk
  ghostty
  chromium
  papers
  zotero
  epiphany
  antigravity-fhs
  pyright
  wl-clipboard
  telegram-desktop
  ptyxis
  pyright
  zeal
  gnome-disk-utility
  gnome-system-monitor
  code-cursor-fhs
  kiro-fhs
  obsidian
]; 
}
