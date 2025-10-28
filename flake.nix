{
  description = "A sample NixOS-on-Lima configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-lima = {
      url = "github:nixos-lima/nixos-lima/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-lima, home-manager, nixvim, ... }@inputs:
    let
      system = "aarch64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = { inherit nixos-lima; };
          modules = [
            ./nixos-lima-config.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.wdaughtridge = ./home.nix;
              users.users.wdaughtridge.isSystemUser = true;
              users.users.wdaughtridge.group = "users";
              users.users.wdaughtridge.home = "/home/wdaughtridge.linux";
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
            }
          ];
        };
    };    
}
