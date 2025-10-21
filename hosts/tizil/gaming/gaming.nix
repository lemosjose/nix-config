{ config, lib, pkgs, ... }:
{
  imports = [
    ../hardware-configuration.nix
  ];
  specialisation = { 
    playstation = { 
      inheritParentConfig = false;
      configuration = {

        imports = [ 
	        ../hardware-configuration.nix
	      ];

        #using the same from my host system 
	      system = { 
	        stateVersion = "23.11";
          nixos.tags = [ "Playstation" ];
	      };

	      nixpkgs.config.allowUnfree = true;

	      boot = { 
	        kernelParams = [
	          "quiet"
		        "splash"
		        "amd_pstate=active"
	        ];

	        plymouth.enable = true;

	        kernelPackages = pkgs.linuxPackages_latest;

	        supportedFilesystems = ["ntfs"];

	        initrd.kernelModules = [ "amdgpu" ];
	      };

	      hardware = { 
	        enableAllFirmware = true;

          graphics = {
            enable = true;
            enable32Bit = true;
          };
	        amdgpu = { 
		        initrd.enable = true;
	        };
	      };
	      
	      networking = {
	        networkmanager.enable = true;
	        dhcpcd.enable = true;
	      };

	      time.timeZone = "America/Sao_Paulo";

	      services = {
	        pipewire = {
	          enable = true;
		        alsa.enable = true;
		        alsa.support32Bit = true;
		        pulse.enable = true;
	        };

          flatpak.enable = true;

	        xserver = { 
		        desktopManager.gnome.enable = true; 
		        displayManager.gdm.enable = true;
          };
          
		      gvfs.enable = true; 
		      devmon.enable = true;
		      tumbler.enable = true;


		      geoclue2.enable = true;
	      };

	      xdg.portal = {
	        wlr.enable = true; 
	        xdgOpenUsePortal = true;
	      };

	      security.polkit.enable = true; 

	      location.provider = "geoclue2";


	      #packages


	      environment.systemPackages = with pkgs; [
	        ffmpeg-full
	        brightnessctl 
	        openvpn
	        cmake
	        steam-rom-manager
	        libretro.nestopia
	        libretro.snes9x 
	        libretro.genesis-plus-gx
	        retroarchFull
	        neovim
	        vulkan-tools
	      ];

	      programs = {
	        gamescope = { 
	          enable = true; 
		        capSysNice = true; 
	        };
	        steam = {
	          enable = true;
		        localNetworkGameTransfers.openFirewall = true;
		        gamescopeSession.enable = true;
	        };

	        gamemode = { 
	          enable = true;
		        settings = {
		          general = { 
		            renice = 10; 
		          };
		          
		          gpu = { 
		            apply_gpu_optimisations = "accept-responsibility"; 
			          gpu_device = 0;
			          amd_performance_level = "high";
		          };
		        };
	        };          
	      };

        users.users.Travis = { 
	        isNormalUser = true; 
	        extraGroups = ["adbusers" "wheel" "libvirtd" "input" "audio" "gamemode" "networkmanager"];
          
          hashedPassword = "$y$j9T$ThUZGEDD65jKe8H2473wv1$DdGOjKZ0eVNr3kk/48i8RoM4O502JYpgPHf76EJZJ0C";
          
          packages = with pkgs; [
            keepassxc
            discord
            mpv
            kdePackages.okular
            vlc
            ptyxis
            firefox
            pavucontrol
            spotify
            gimp
            python3Full
            emacs-pgtk
            protonup
            rpcs3
            obs-studio
            steam-run
            heroic
            bottles
            lutris
            mangohud
            papers
            gnome-tweaks
          ];
	      };
      };
      };
    };
}
