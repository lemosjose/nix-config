{
  pkgs,
  inputs,
  ...
}: {
specialisation = {
  playstation = {
    inheritParentConfig = false;
    _module.args = {
      inherit pkgs inputs;
    };
    configuration = {

      boot.plymouth.enable = true;

      system.stateVersion = "25.11";
      
      nixpkgs.hostPlatform = pkgs.system;
      nixpkgs.config.allowUnfree = true;
      
      imports = [
        inputs.disko.nixosModules.disko
        inputs.jovian.nixosModules.default
        inputs.hardware.nixosModules.common-cpu-amd
        inputs.hardware.nixosModules.common-gpu-amd
        inputs.hardware.nixosModules.common-pc-ssd
        inputs.home-manager.nixosModules.home-manager
        inputs.nix-flatpak.nixosModules.nix-flatpak
        
        ../disko.nix
        ../../common/users/Travis
        ../hardware-configuration.nix
      ];

      environment.systemPackages = with pkgs; [
        dolphin-emu
        (retroarch.withCores (cores: with cores; [
          genesis-plus-gx
          snes9x
          bsnes
          citra
          ppsspp
          flycast
          quicknes
          mgba
          puae
          gambatte
        ]))
      ];

      time.timeZone = "America/Sao_Paulo";

      networking.networkmanager.enable = true;
      networking.networkmanager.wifi.powersave = false; 

      networking.hostName = "Playstation"; 
      
      services = {
        openssh.enable = true;
        desktopManager.plasma6.enable = true;
        flatpak.enable = true;
        flatpak.packages = [
          "net.lutris.Lutris"
          "com.heroicgameslauncher.hgl"
          "net.pcsx2.PCSX2"
          "info.cemu.Cemu"
          "app.xemu.xemu"
          "org.telegram.desktop"
        ];
      };

      hardware = {
        bluetooth.enable = true;
        enableAllFirmware = true;
        graphics = {
          enable = true;
          enable32Bit = true; 
        };
        xone.enable = true;
        cpu.amd = {
          updateMicrocode = true;
          ryzen-smu.enable = true; 
        }; 
      };
      
      jovian = {
        hardware = {
          has.amd.gpu = true;
          amd.gpu.enableBacklightControl = false; 
        };

        steam = {
          updater.splash = "vendor";
          enable = true;
          autoStart = true;
          user = "Travis";
          #mesmerizing steamOS even more
          desktopSession = "plasma";
        };

        steamos = {
          useSteamOSConfig = true;
        };
        
      };

    };
  };
};

}
