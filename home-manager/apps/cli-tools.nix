{
  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    eza.enable = true;

    bat.enable = true;

    fd.enable = true;

    ripgrep.enable = true;

    yazi = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        manager = {
          ratio = [1 3 4];
        };
        preview = {
          image_filter = "catmull-rom";
        };
      };
    };
  };
}
