{ homeStateVersion, user, ... }:
{
  imports = [
    ./apps
    ./bin
    ./coding
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion; # Please read the comment before changing.

    sessionVariables = {
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
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
