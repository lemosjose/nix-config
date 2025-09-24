{ config, lib, pkgs, ... }:

{
#not uniting untill 25.11
  services.xserver = { 
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = [ pkgs.geary pkgs.totem pkgs.gnome-weather pkgs.gnome-music ];
}

