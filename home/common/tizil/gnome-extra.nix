{
  pkgs,
  lib,
  ...
}:{
home.packages = lib.mkAfter [
  pkgs.gnome-calendar
  pkgs.showtime
];
}
