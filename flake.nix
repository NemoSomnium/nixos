{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";
    nixpkgs-unfree-master.url = "github:numtide/nixpkgs-unfree";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland.url = "github:hyprwm/Hyprland";

    stylix.url = "github:danth/stylix";
    
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = { self, nixpkgs, nixpkgs-master, nixpkgs-unfree-master, home-manager, nixos-hardware, ... }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.framework = nixpkgs.lib.nixosSystem {
       specialArgs = { inherit inputs; };
        modules = [
          ./hosts/framework/configuration.nix
	        ./modules/vmware/vmware.nix
	        ./modules/packettracer/packettracer.nix
	        ./modules/gnome-extensions/gnome-extensions.nix
	        ./modules/stylix/stylix.nix
          ./modules/lvim/python.nix
          ./modules/autostart/1password.nix
	        inputs.stylix.nixosModules.stylix
	        inputs.nixvim.nixosModules.nixvim
      	  inputs.nixos-hardware.nixosModules.framework-13-7040-amd
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
}
