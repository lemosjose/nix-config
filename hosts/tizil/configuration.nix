{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./gnome.nix
      #My second Playstation 
      ./gaming/gaming.nix
    ];

  hardware = {
    enableAllFirmware = true; 

    graphics = {
      enable = true;
	    enable32Bit = true;
    };
  };

  #nixpkgs.config.allowUnfree = true;

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
      "pcie_aspm=off"
	    "amdgpu.ppfeaturemask=0xffffffff"
	    "amdgpu.gpu_recovery=1"
	    "quiet"
	    "splash"
    ];

    initrd.kernelModules = [ "amdgpu" ];

    supportedFilesystems = ["ntfs"];  
  };

  ##backup for when emacs breaks with some kernel stuff, i don't know why it happens 
  # boot.kernelPackages = pkgs.linuxPackages.extend (lpFinal: lpPrev: {
  #     cpupower = lpPrev.cpupower.overrideAttrs (old: {
  #       nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ pkgs.which ];
  #       makeFlags = (old.makeFlags or []) ++ [ "INSTALL_NO_TRANSLATIONS=1" ];
  #     });
  # });

  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs = { 
    dconf.enable = true; 
    #spooky!
    nix-ld.enable = true;
    virt-manager.enable = true;
    adb.enable = true;

    gamemode.enable = true;

    #just to remove the warning 
    zsh.enable = true; 

    kdeconnect = { 
      enable = true; 
	    package = pkgs.gnomeExtensions.gsconnect;
    };
  };

  #i hate missing fonts

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.fira-code 
    nerd-fonts.ubuntu 
    nerd-fonts.jetbrains-mono 
    dejavu_fonts 
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans 
    noto-fonts-emoji
    powerline-fonts
    corefonts
    powerline-symbols
  ];

  services = {
    udev = {
      enable = true; 
	    packages = with pkgs; [ android-udev-rules gnome-settings-daemon];
    };

    ollama = {
      enable = true;
	    acceleration = "rocm";
	    #i prefer to keep it here just remember the value without running nix-shell for rocmPackages
	    environmentVariables = { 
	      HCC_AMDGPU_TARGET = "gfx1032";
	      HSA_OVERRIDE_GFX_VERSION= "10.3.0";
	      HIP_VISIBLE_DEVICES = "0";
	    };

	    loadModels = [ "deepseek-r1:latest" "llama3.1:latest" ];
    };

    gvfs.enable = true; 

    udisks2.enable = true; 

    tumbler.enable = true;

    devmon.enable = true;

    touchegg.enable = true;

    flatpak.enable = true;

    pipewire = {
      enable = true;
      wireplumber.enable = true; 

	    alsa.enable = true; 
	    alsa.support32Bit = true; 
	    pulse.enable = true;
    };

    xserver = { 
      enable = true; 
	    videoDrivers = [ "amdgpu" ];
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

  powerManagement.cpuFreqGovernor = "performance";


  environment = { 
    pathsToLink = [ "/libexec" ];
    localBinInPath = true;
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    }; 

    waydroid.enable = true;      
  };

  time.timeZone = "America/Sao_Paulo";
  
  users.defaultUserShell = pkgs.zsh;
  
  #Garras da patrulha hostname and networking
  networking = {
    hostName = "tizil";
    networkmanager.enable = true;
    firewall = { 
      enable = true;
	    allowedTCPPorts = [
        8080
	      9090
        1234
      ];
    };
  };
  system.stateVersion = "23.11"; # Did you read the comment?

}

