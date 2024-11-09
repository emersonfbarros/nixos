{
  imports = [
    ./apps/index.nix
    ./bin/index.nix
    ./coding/index.nix
    ./env/index.nix
  ];

  home.username = "emerson";
  home.homeDirectory = "/home/emerson";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
