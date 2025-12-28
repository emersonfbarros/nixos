{ pkgs, ... }:
{
  programs.gpg = {
    enable = true;
    settings = {
      default-key = "5C2B1DF2F1C83884"; # Replace with your key ID
      pinentry-mode = "loopback";
    };
  };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    enableSshSupport = false; # We're using ssh-agent separately
    enableExtraSocket = true;
    defaultCacheTtl = 1800; # 30 minutes
    maxCacheTtl = 7200; # 2 hours
    pinentry.package = pkgs.pinentry-curses; # Or "qt" if you use KDE, "curses" for terminal
    extraConfig = "allow-loopback-pinentry";
  };
}
