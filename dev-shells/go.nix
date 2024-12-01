{
  description = "Go development flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.${"x86_64-linux"};
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "go-shell";

        # Include necessary dependencies
        packages = [
          pkgs.go
          pkgs.binutils
          pkgs.glibc
        ];

        # Configure linker to avoid executable stack warnings
        shellHook = ''
          export CGO_LDFLAGS="-Wl,-z,noexecstack"
        '';
      };
    };
}
