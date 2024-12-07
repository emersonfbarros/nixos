{
  description = "My NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix
          inputs.stylix.nixosModules.stylix
          # To nixd find <nixpkgs>
          {
            nix.nixPath = [
              "nixpkgs=${inputs.nixpkgs}"
              # Add home-manager to nixPath if you want nixd to understand HM options
              "home-manager=${inputs.home-manager}"
            ];
          }
        ];
      };

      homeConfigurations.emerson = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};

        modules = [
          ./home-manager/home.nix
          inputs.stylix.homeManagerModules.stylix

        ];

        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
}
