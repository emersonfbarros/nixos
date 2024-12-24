{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Emerson Barros";
    userEmail = "emersonfb99@gmail.com";
    signing = {
      key = "5C2B1DF2F1C83884";
      signByDefault = true;
    };
    extraConfig = {
      gpg.program = "${pkgs.gnupg}/bin/gpg2";

      url = {
        "ssh://git@github.com" = {
          insteadOf = ''https://github.com'';
        };
      };

      delta = {
        navigate = true;
        side-by-side = true;
      };
    };

    delta.enable = true;
  };
}
