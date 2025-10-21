{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./gnome.nix
      ./laptop.nix
    ];

  hardware = {
    enableAllFirmware = true; 

    graphics = { 
      enable = true;
	    enable32Bit = true; 
    };

    nvidia = { 
      open = false; 
	    modesetting.enable = true;
	    nvidiaSettings = false;
	    prime = {
	      sync.enable = true;

	      intelBusId = "PCI:0:2:0";
	      nvidiaBusId = "PCI:1:0:0";
	    };
    };
  };

  nixpkgs = { 
     config.allowUnfree = true;
  };

  boot = {
    loader.systemd-boot = { 
      enable = true; 
	    memtest86.enable = true;
    };

    loader.efi.canTouchEfiVariables = true;

    plymouth.enable = true; 

    kernelParams = [
	    "quiet"
	    "splash"
    ];


    kernelPackages = pkgs.linuxPackages_latest;

    supportedFilesystems = ["ntfs"];  
  };


  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs = { 
    dconf.enable = true; 
    #spooky!
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [avrdude];
    virt-manager.enable = true;
    adb.enable = true;

    gamemode.enable = true;

    #just to remove the warning 
    zsh.enable = true; 

  };

  #fonts fixing 

  fonts.packages = with pkgs; [
    font-awesome
    powerline-fonts
    powerline-symbols
  ];

  services = {

    xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      videoDrivers = [ "nouveau" ] ;
    };
    
    udev = {
      enable = true; 
	    packages = with pkgs; [ android-udev-rules platformio-core platformio-core.udev openocd ];
    };

    gvfs.enable = true; 

    udisks2.enable = true; 

    tumbler.enable = true;

    touchegg.enable = true;

    flatpak.enable = true;

    pipewire = {
      enable = true;
      wireplumber.enable = true; 

	    alsa.enable = true; 
	    alsa.support32Bit = true; 
	    pulse.enable = true;
    };

    mullvad-vpn = { 
      enable = true; 
	    package = pkgs.mullvad-vpn;
    }; 
  };

  xdg.portal = { 
    wlr.enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "*";
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };


  environment = { 
    pathsToLink = [ "/libexec" ];
    localBinInPath = true;
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    }; 

    libvirtd.enable = true;

    spiceUSBRedirection.enable = true;
  };

  time.timeZone = "America/Sao_Paulo";
  
  users.defaultUserShell = pkgs.zsh;

  #Garras da patrulha hostname and networking
  networking = {
    hostName = "tabosa";
    networkmanager.enable = true;
    firewall = { 
      enable = true;
	    allowedTCPPorts = [ 8080
	                        9090
                          1234
                        ];
    };
  };

  system.stateVersion = "23.11"; # Did you read the comment?

}

