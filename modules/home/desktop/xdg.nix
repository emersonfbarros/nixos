{
  flake.modules.homeManager.xdg =
    { pkgs, config, ... }:
    {
      xdg = {
        portal = {
          enable = true;
          xdgOpenUsePortal = true;

          config = {
            common = {
              default = [ "gtk" ];
            };
            sway = {
              default = [ "gtk" ];
              "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
              "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
            };
          };
          extraPortals = with pkgs; [
            xdg-desktop-portal-wlr
            xdg-desktop-portal-gtk
          ];
        };

        mime.enable = true;
        mimeApps = {
          enable = true;

          defaultApplications = {
            "x-scheme-handler/http" = "firefox.desktop";
            "x-scheme-handler/https" = "firefox.desktop";
            "text/html" = "firefox.desktop";
            "x-scheme-handler/mailto" = "firefox.desktop";
            "x-scheme-handler/webcal" = "firefox.desktop";
            "image/png" = "swayimg.desktop";
            "image/jpeg" = "swayimg.desktop";
            "image/gif" = "swayimg.desktop";
            "image/svg" = "swayimg.desktop";
            "video/mp4" = "mpv.desktop";
            "video/x-matroska" = "mpv.desktop";
            "video/webm" = "mpv.desktop";
            "inode/directory" = "thunar.desktop";
            "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
          };
        };

        userDirs = {
          enable = true;
          createDirectories = true;
          music = "${config.home.homeDirectory}/Media/Music";
          videos = "${config.home.homeDirectory}/Media/Videos";
          pictures = "${config.home.homeDirectory}/Media/Pictures";
          templates = "${config.home.homeDirectory}/Templates";
          download = "${config.home.homeDirectory}/Downloads";
          documents = "${config.home.homeDirectory}/Documents";
          desktop = null;
          publicShare = null;
          extraConfig = {
            XDG_ORG_DIR = "${config.home.homeDirectory}/Org";
            XDG_REPOSITORIES_DIR = "${config.home.homeDirectory}/Repos";
            XDG_PODCAST_DIR = "${config.home.homeDirectory}/Media/Podcasts";
            XDG_BOOK_DIR = "${config.home.homeDirectory}/Media/Books";
            XDG_ARCHIVE_DIR = "${config.home.homeDirectory}/Archive";
          };
        };
      };
    };
}
