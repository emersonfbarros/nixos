{ pkgs, ... }:

{
  # Add base development tools to your environment
  home.packages = with pkgs; [
    rustc
    cargo

    nodejs
    python3
  ];

  programs.go = rec {
    enable = true;
    goPath = "go";
    goBin = "${goPath}/bin";
  };
}
