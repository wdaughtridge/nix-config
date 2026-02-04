{
  description = "Home Manager configuration of wdaughtridge";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-2.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix.url = "github:helix-editor/helix";
    zig.url = "github:mitchellh/zig-overlay";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-2,
      home-manager,
      helix,
      zig,
      ...
    }@inputs:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-2 = nixpkgs-2.legacyPackages.${system};
    in
    {
      homeConfigurations."wdaughtridge" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./home.nix ];

        extraSpecialArgs = {
          inherit inputs;
          inherit pkgs-2;
          inherit helix;
          inherit zig;
        };
      };
    };
}
