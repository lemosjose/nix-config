{
  description = "Simple nix configuration (do not overestimate me when it comes to nix!)";


  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = { 
      url = "github:nix-community/home-manager/release-25.05";
	    inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    systems.url = "github:nix-systems/default-linux";

    hardware.url = "github:nixos/nixos-hardware";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs-stable";
      inputs.home-manager.follows = "home-manager";
    };

    
  };


  outputs = {
    self,
    nixpkgs-stable,
    home-manager,
    systems,
    firefox-addons, 
    hardware,
    plasma-manager,
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs-stable.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
      import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      }
    );

  in{

    inherit lib;

    nixosConfigurations = {

      #main desktop 
      tizil = lib.nixosSystem {
        modules = [./hosts/tizil];
        specialArgs = {
          inherit inputs outputs;
        };
      };

      #laptop (Samsung)
      tabosa = lib.nixosSystem {
        modules = [./hosts/tabosa];
        specialArgs = {
          inherit inputs outputs;
        };
      };
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
