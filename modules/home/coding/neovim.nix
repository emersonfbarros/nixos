{
  flake.modules.homeManager.neovim-config =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      nvimConfigRepo = "https://github.com/emersonfbarros/config.nvim";
      nvimConfigPath = "${config.home.homeDirectory}/Repos/personal/config.nvim";
    in
    {
      # Ensure Neovim is installed
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        withNodeJs = true;
        withPython3 = true;

        # Essential dependencies for many plugins
        extraPackages = with pkgs; [
          gcc
          ripgrep
          fd
          unzip
          wl-clipboard
        ];
      };

      # Activation script to clone the repository if it doesn't exist
      home.activation.cloneNvimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ ! -d "${nvimConfigPath}" ]; then
          echo "Cloning Neovim configuration..."
          # Create parent directory if it doesn't exist
          mkdir -p $(dirname "${nvimConfigPath}")
          ${pkgs.git}/bin/git clone ${nvimConfigRepo} "${nvimConfigPath}"
        fi
      '';

      # Symlink the external configuration
      xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink nvimConfigPath;
    };
}
