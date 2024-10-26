{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    # Add your SSH keys to be managed
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/id_ed25519"; # Replace with your key path
      };
    };
  };

  services.ssh-agent.enable = true;

  home.sessionVariables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
  };
}
