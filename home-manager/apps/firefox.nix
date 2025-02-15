{ inputs, user, ... }:
{
  programs.firefox = {
    enable = true;

    profiles.${user} = {
      isDefault = true;

      containers = {
        Personal = {
          id = 1;
          color = "blue";
          icon = "fingerprint";
        };
        Professional = {
          id = 2;
          color = "green";
          icon = "dollar";
        };
        Work = {
          id = 3;
          color = "yellow";
          icon = "briefcase";
        };
      };

      search = {
        default = "DuckDuckGo";
        privateDefault = "Google";
        order = [
          "DuckDuckGo"
          "Google"
        ];
      };

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        privacy-badger
        translate-web-pages
        ublock-origin
        youtube-shorts-block
      ];

      bookmarks = [
        {
          name = "Utils";
          bookmarks = [
            {
              name = "Sheets";
              url = "https://docs.google.com/spreadsheets/u/0/";
            }
            {
              name = "Translate";
              url = "https://translate.google.com/?sl=pt&tl=en&op=translate";
            }
            {
              name = "GitHub";
              url = "https://github.com";
            }
            {
              name = "Slack";
              url = "https://slack.com";
            }
            {
              name = "Pomodor";
              url = "https://pomodor.app";
            }
          ];
        }
        {
          name = "Google";
          bookmarks = [
            {
              name = "Gmail";
              url = "https://mail.google.com/mail/u/0/";
            }
            {
              name = "Drive";
              url = "https://drive.google.com/drive/my-drive";
            }
            {
              name = "Calendar";
              url = "https://calendar.google.com/calendar/u/0/r/week";
            }
            {
              name = "Maps";
              url = "https://www.google.com/maps?authuser=0";
            }
            {
              name = "Google";
              url = "https://google.com";
            }
          ];
        }
        {
          name = "Social";
          bookmarks = [
            {
              name = "WhatsApp";
              url = "https://web.whatsapp.com";
            }
            {
              name = "Telegram";
              url = "https://web.telegram.org/z";
            }
            {
              name = "Reddit";
              url = "https://reddit.com";
            }
            {
              name = "Linkedin";
              url = "https://linkedin.com";
            }
            {
              name = "Discord";
              url = "https://discord.com/channels/@me";
            }
            {
              name = "Instagram";
              url = "https://instagram.com";
            }
            {
              name = "Twitter";
              url = "https://twitter.com";
            }
          ];
        }
        {
          name = "News";
          bookmarks = [
            {
              name = "BBC Brasil";
              url = "https://bbc.com/portuguese";
            }
            {
              name = "Nexo";
              url = "https://nexojornal.com.br";
            }
            {
              name = "UOL Notícias";
              url = "https://noticias.uol.com.br";
            }
            {
              name = "New York Times";
              url = "https://nytimes.com";
            }
            {
              name = "BBC International";
              url = "https://bbc.com";
            }
            {
              name = "CNN";
              url = "https://edition.cnn.com/";
            }
            {
              name = "O Globo";
              url = "https://oglobo.globo.com";
            }
            {
              name = "Folha de São Paulo";
              url = "https://folha.uol.com.br";
            }
            {
              name = "G1";
              url = "https://g1.globo.com/";
            }
            {
              name = "G1 Alagoas";
              url = "https://g1.globo.com/al/alagoas/";
            }
            {
              name = "Piauí";
              url = "https://piaui.folha.uol.com.br/";
            }
          ];
        }
        {
          name = "Media";
          bookmarks = [
            {
              name = "Genius";
              url = "https://genius.com";
            }
            {
              name = "Spotify";
              url = "https://spotify.com";
            }
            {
              name = "Youtube";
              url = "https://youtube.com";
            }
            {
              name = "Freedium";
              url = "https://freedium.cfd/";
            }
          ];
        }
      ];

      extraConfig =
        let
          betterFoxUserJs = builtins.readFile (
            builtins.fetchurl {
              url = "https://raw.githubusercontent.com/yokoffing/Betterfox/main/user.js";
              sha256 = "sha256:1fr0ia7zjszy31sdp05h746b88761wswrwr61zw7hvn1a8dkvhaw";
            }
          );
        in
        ''
          ${betterFoxUserJs}

          // Overrides
          user_pref("identity.fxaccounts.enabled", false); // Disable account syncing

          // Smoothness on scrolling
          // Sharpen Scrolling
          user_pref("apz.overscroll.enabled", true); // DEFAULT NON-LINUX
          user_pref("general.smoothScroll", true); // DEFAULT
          user_pref("mousewheel.min_line_scroll_amount", 10); // 10-40; adjust this number to your liking; default=5
          user_pref("general.smoothScroll.mouseWheel.durationMinMS", 80); // default=50
          user_pref("general.smoothScroll.currentVelocityWeighting", "0.15"); // default=.25
          user_pref("general.smoothScroll.stopDecelerationWeighting", "0.6"); // default=.4

          // OPTION: INSTANT SCROLLING (SIMPLE ADJUSTMENT)
          // recommended for 60hz+ displays
          user_pref("apz.overscroll.enabled", true); // DEFAULT NON-LINUX
          user_pref("general.smoothScroll", true); // DEFAULT
          user_pref("mousewheel.default.delta_multiplier_y", 275); // 250-400; adjust this number to your liking

          // UI options
          user_pref("browser.startup.page", 3); // Restore session on startup
          user_pref("privacy.userContext.enabled", true); // Enable tabs containers
          user_pref("privacy.userContext.newTabContainerOnLeftClick.enabled", true);

          user_pref("browser.download.useDownloadDir", false); // Always ask you where to save files

          user_pref("browser.uidensity", 1); // UI compat density
        '';
    };
  };
}
