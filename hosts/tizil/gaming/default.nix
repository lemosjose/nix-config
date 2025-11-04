{
  pkgs,
  inputs,
  ...
}: {
specialisation = {
  playstation = {
    inheritParentConfig = false;
    configuration = {

      system.stateVersion = "25.11";

      imports = [
        inputs.jovian.nixosModules.default
        inputs.hardware.nixosModules.common-cpu-amd
        inputs.hardware.nixosModules.common-gpu-amd
        inputs.hardware.nixosModules.common-pc-ssd
        inputs.home-manager.nixosModules.home-manager
        
        ../hardware-configuration.nix
        ../../common/users/Travis
      ];
      

      nixpkgs.hostPlatform = pkgs.system;
      nixpkgs.config.allowUnfree = true; 

      environment.systemPackages = [
        pkgs.firefox
        pkgs.lutris
        pkgs.heroic
        pkgs.gogdl
      ];

      time.timeZone = "America/Sao_Paulo";

      networking.networkmanager.enable = true;
      networking.networkmanager.wifi.powersave = false; 

      networking.hostName = "Playstation"; 
      
      services = {
        openssh.enable = true;
        desktopManager.plasma6.enable = true;
      };

      hardware = {
        bluetooth.enable = true;
        enableAllFirmware = true; 
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
