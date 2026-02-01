{
  inputs,
  lib,
  config,
  self,
  ...
}:
let
  inherit (lib) types mkOption;
in
{
  options =
    let
      baseHostModule =
        { config, ... }:
        {
          options = {
            system = mkOption {
              type = types.str;
              default = "x86_64-linux";
            };

            unstable = lib.mkOption {
              type = types.bool;
              default = false;
            };

            modules = lib.mkOption {
              type = with types; listOf deferredModule;
              default = [ ];
            };

            nixpkgs = lib.mkOption {
              type = types.pathInStore;
            };
            pkgs = lib.mkOption {
              type = types.pkgs;
            };

            # Contains the final package for this configuration
            package = lib.mkOption {
              type = types.package;
            };
          };
          config = {
            nixpkgs = if config.unstable then inputs.nixpkgs else inputs.nixpkgs-stable;
            pkgs = import config.nixpkgs {
              inherit (config) system;
              config.allowUnfree = true;
            };
          };
        };

      hostTypeNixos = types.submodule [
        baseHostModule
        (
          { name, ... }:
          {
            modules = [
              config.flake.modules.nixos.core
              { networking.hostName = name; }
              (config.flake.modules.nixos."host_${name}" or { })
            ];
            package = self.nixosConfigurations.${name}.config.system.build.toplevel;
          }
        )
      ];
    in
    {
      nixosHosts = mkOption { type = types.attrsOf hostTypeNixos; };
    };

  config = {
    flake = {
      nixosConfigurations =
        let
          mkHost =
            hostname: hostConfig:

            hostConfig.nixpkgs.lib.nixosSystem {
              inherit (hostConfig) system;
              modules = hostConfig.modules ++ [
                {
                  nixpkgs.pkgs = hostConfig.pkgs;
                }
              ];
              specialArgs = {
                inherit inputs;
              };
            };
        in
        lib.mapAttrs mkHost config.nixosHosts;
    };
  };
}
