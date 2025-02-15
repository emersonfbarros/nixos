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
      BROWSER = "firefox";
      COLORTERM = "truecolor";
      EDITOR = "nvim";
      IMAGE = "swayimg";
      MANPAGER = "nvim +Man!";
      NIXOS_OZONE_WL = "1";
      OPENER = "xdg-open";
      PAGER = "less";
      READER = "zathura";
      SUDOEDIT = "nvim";
      TERMINAL = "kitty";
      VIDEO = "mpv";
      VISUAL = "nvim";
      WM = "sway";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
