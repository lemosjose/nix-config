{
  description = "Simple nix configuration (do not overestimate me when it comes to nix!)";


  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = { 
      url = "github:nix-community/home-manager/release-25.05";
	    inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };


  outputs = { self, nixpkgs-stable, home-manager }@inputs: 
    let
      
      homeManagerBase = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users.lemos = import ./home-configurations/lemos/lemos.nix;
      };
      

      mainHost = {
          home-manager.extraSpecialArgs = { inherit inputs; }; 
          home-manager.users.Joseph = import ./home-configurations/Joseph/Work.nix;
     };       
     
      
      mkNixosSystem = configurationNix: extraModules:
        nixpkgs-stable.lib.nixosSystem {             
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            configurationNix
            home-manager.nixosModules.home-manager
            homeManagerBase
            extraModules
          ];
        };

    in {
      nixosConfigurations = {
        tizil  = mkNixosSystem ./hosts/tizil/configuration.nix mainHost;
        tabosa = mkNixosSystem ./hosts/tabosa/configuration.nix [];
      };

      #For WSL2 and (maybe :^) ) other distros
      homeConfigurations."lemos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-stable.legacyPackages."x86_64-linux";
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home/lemos.nix
          {
            home.username = "lemos";
            home.homeDirectory = "/home/lemos";
            nixpkgs.config.allowUnfree = true;
          }
        ];
      };
    };
}
