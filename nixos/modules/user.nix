{ pkgs, ... }:
{
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;

    users.emerson = {
      isNormalUser = true;
      description = "emerson";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages = [ ];
    };
  };

  # doesn't work on home-manager :/
  services.twingate.enable = true;
}
