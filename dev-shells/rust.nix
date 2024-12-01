{
  description = "rust development flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.${"x86_64-linux"};
      overrides = builtins.fromTOML (builtins.readFile ./rust-toolchain.toml);
      libPath = pkgs.lib.makeLibraryPath [
        pkgs.openssl
      ];
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "rust-shell";

        buildInputs = with pkgs; [
          clang
          llvmPackages.bintools
          rustup
          pkg-config
          openssl
        ];

        RUSTC_VERSION = overrides.toolchain.channel;
        LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];

        shellHook = ''
          export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
          export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin/
          export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig"

          # Install the WebAssembly target if not already installed
          if ! rustup target list --installed | grep -q wasm32-unknown-unknown; then
            rustup target add wasm32-unknown-unknown
          fi
        '';

        RUSTFLAGS = (
          builtins.map (a: ''-L ${a}/lib'') [
            pkgs.openssl
          ]
        );

        LD_LIBRARY_PATH = libPath;

        BINDGEN_EXTRA_CLANG_ARGS =
          (builtins.map (a: ''-I"${a}/include"'') [
            pkgs.glibc.dev
          ])
          ++ [
            ''-I"${pkgs.llvmPackages_latest.libclang.lib}/lib/clang/${pkgs.llvmPackages_latest.libclang.version}/include"''
            ''-I"${pkgs.glib.dev}/include/glib-2.0"''
            ''-I${pkgs.glib.out}/lib/glib-2.0/include/''
          ];
      };
    };
}
