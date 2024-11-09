{ pkgs, ... }:

{
  # Add base development tools to your environment
  home.packages = with pkgs; [
    go

    rustc
    cargo

    nodejs
    python3
  ];
}
