{
  programs = {
    yazi = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        manager = {
          ratio = [ 1 3 4 ];
        };
        preview = {
          image_filter = "catmull-rom";
        };
      };
    };
  };
}
