{
  flake.modules.homeManager.langs =
    { pkgs, config, ... }:
    {
      home.packages = with pkgs; [
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
    };
}
