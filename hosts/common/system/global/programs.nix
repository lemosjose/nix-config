{
  pkgs,
  ...
}:{
programs = { 
  dconf.enable = true; 
  #spooky!
  nix-ld.enable = true;
  adb.enable = true;

  zsh.enable = true;
};
}
