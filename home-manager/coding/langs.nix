{ pkgs, config, ... }:

{
  # Add base development tools to your environment
  home.packages = with pkgs; [
    rustc
    cargo

    nodejs
    python3
  ];

  programs.go = {
    enable = true;
    env = rec {
      GOPATH = config.home.homeDirectory + "/go";
      GOBIN = "${GOPATH}/bin";
    };
    telemetry.mode = "off";
  };
}
