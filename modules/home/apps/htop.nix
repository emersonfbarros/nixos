{
  flake.modules.homeManager.htop = {
    programs.htop = {
      enable = true;
      settings = {
        tree_view = 1;
      };
    };
  };
}
