{ pkgs, ... }:
{
  home.pointerCursor = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;

    gtk.enable = true;
    x11.enable = true;
  };

  gtk.cursorTheme = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
  };

  dconf.settings."org/gnome/desktop/interface" = {
    cursor-theme = "Adwaita";
    cursor-size = 24;
  };
}
