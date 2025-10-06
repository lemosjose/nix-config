{
  description = "Simple nix configuration";


  inputs = {
     nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

     home-manager = { 
         url = "github:nix-community/home-manager/release-25.05";
	       inputs.nixpkgs.follows = "nixpkgs-stable";
     };
  };


  outputs = { self, nixpkgs-stable, home-manager }@inputs: 
     let
      
         homeManagerModules = [
             home-manager.nixosModules.home-manager
             {
                 home-manager.useGlobalPkgs = true;
                 home-manager.useUserPackages = true;
                 home-manager.extraSpecialArgs = { inherit inputs; };
                 home-manager.users.lemos = import ./home/lemos.nix;
             }
         ];
         mkNixosSystem = configurationNix: nixpkgs-stable.lib.nixosSystem {
           system = "x86_64-linux";
           specialArgs = { inherit inputs; };
           modules = [ configurationNix ] ++ homeManagerModules;
         };

     in {
       nixosConfigurations = {
         tizil  = mkNixosSystem ./hosts/tizil/configuration.nix;
         tabosa = mkNixosSystem ./hosts/tabosa/configuration.nix;
       };
     };
}
