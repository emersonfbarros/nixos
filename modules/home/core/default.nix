{
  flake.modules.homeManager.core =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      home = {
        username = lib.mkDefault "emerson";
        homeDirectory = "/${if pkgs.stdenv.isLinux then "home" else "Users"}/${config.home.username}";
        stateVersion = "25.11";
      };

      # Let Home Manager install and manage itself
      programs.home-manager.enable = true;
    };
}
