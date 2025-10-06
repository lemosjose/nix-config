{ config, lib, pkgs, ... }:

{
  services.xserver = { 
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      videoDrivers = [ "nouveau" ];
  };
}

