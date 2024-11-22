{
  imports = [
    ./apps/index.nix
    ./bin/index.nix
    ./coding/index.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  home.username = "emerson";
  home.homeDirectory = "/home/emerson";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SUDOEDIT = "nvim";
    READER = "zathura";
    TERMINAL = "kitty";
    BROWSER = "chromium";
    VIDEO = "mpv";
    IMAGE = "swayimg";
    COLORTERM = "truecolor";
    OPENER = "xdg-open";
    PAGER = "less";
    WM = "sway";
    MANPAGER = "nvim +Man!";
    NIXOS_OZONE_WL = "1";
  };

  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
