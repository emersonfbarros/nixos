{
  description = "Go development flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    old-go.url = "github:nixos/nixpkgs/e3945057be467f32028ff6b67403be08285ad8c8";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      pkgs = nixpkgs.legacyPackages.${"x86_64-linux"};
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "go-shell";

        # Include necessary dependencies
        packages = [
          inputs.old-go.legacyPackages.${"x86_64-linux"}.go_1_20
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
