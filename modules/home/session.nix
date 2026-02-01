{
  flake.modules.homeManager.session = {
    home.sessionVariables = {
      BROWSER = "firefox";
      COLORTERM = "truecolor";
      EDITOR = "nvim";
      IMAGE = "swayimg";
      MANPAGER = "nvim +Man!";
      NIXOS_OZONE_WL = "1";
      OPENER = "xdg-open";
      PAGER = "bat --plain";
      READER = "zathura";
      SUDOEDIT = "nvim";
      TERMINAL = "kitty";
      VIDEO = "mpv";
      VISUAL = "nvim";
      WM = "sway";
    };
  };
}
