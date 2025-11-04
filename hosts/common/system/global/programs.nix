{
  pkgs,
  ...
}:{
programs = { 
  dconf.enable = true;
  
  #spooky!
  nix-ld.enable = true;
  nix-ld.libraries = with pkgs; [
    glibc
    glib
    zlib
    pango
    gdk-pixbuf
    fontconfig
    cairo
  ];
  
  adb.enable = true;

  zsh.enable = true;
};
}
