{
  description = "nix configuration for a NixOS setup, a Jovian-NixOS config and a Nixxed-debian";


  inputs = {
     nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
     nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

     home-manager = { 
         url = "github:nix-community/home-manager/release-25.05";
	 inputs.nixpkgs.follows = "nixpkgs-stable";
     };
  };


  outputs = { self, nixpkgs, nixpkgs-stable, home-manager }@inputs: 
     let
      
         homeManagerModules = [
             home-manager.nixosModules.home-manager
             {
                 home-manager.useGlobalPkgs = true;
                 home-manager.useUserPackages = true;
                 home-manager.extraSpecialArgs = { inherit inputs; };
                 home-manager.users.lemos = import ./tizil/home/lemos.nix;
             }
         ];
         mkNixosSystem = configurationNix: nixpkgs-stable.lib.nixosSystem {
           system = "x86_64-linux";
           specialArgs = { inherit inputs; };
           modules = [ configurationNix ] ++ homeManagerModules;
         };

     in {
       nixosConfigurations = {
         tizil  = mkNixosSystem ./tizil/configuration.nix;
         tabosa = mkNixosSystem ./tabosa/configuration.nix;
       };
     };

}
