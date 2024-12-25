{
  programs.alacritty = {
    enable = true;

    settings = {
      env.TERM = "xterm-256color";
      scrolling = {
        history = 5000;
        multiplier = 3;
      };
    };
  };
}
