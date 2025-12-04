{
description = "Simple nix configuration (do not overestimate me when it comes to nix!)";

inputs = {

  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

  home-manager = { 
    url = "github:nix-community/home-manager/master";
	  inputs.nixpkgs.follows = "nixpkgs";
  };

  firefox-addons = {
    url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  jovian = {
    url = "github:Jovian-Experiments/Jovian-NixOS?shallow=true";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  hardware.url = "github:nixos/nixos-hardware";

  plasma-manager = {
    url = "github:nix-community/plasma-manager";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };
};

outputs = {
  self,
    nixpkgs,
    home-manager,
    firefox-addons, 
    hardware,
    jovian,
    nix-flatpak,
    plasma-manager,
} @ inputs: let
  inherit (self) outputs;
  hostPlatform.system = "x86_64-linux";
  lib = nixpkgs.lib // home-manager.lib;
  forEachSystem = f: lib.genAttrs (import hostPlatform.system) (system: f pkgsFor.${hostPlatform.system});
  pkgsFor = lib.genAttrs (import hostPlatform.system) (
    system:
    import nixpkgs {
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
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
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
