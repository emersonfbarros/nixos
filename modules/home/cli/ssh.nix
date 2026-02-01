{
  flake.modules.homeManager.ssh = {
    services.ssh-agent.enable = true;
    home.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks = {
        # Default configuration for all hosts
        "*" = {
          addKeysToAgent = "yes";
          compression = false;
          controlMaster = "no";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no";
          forwardAgent = false;
          hashKnownHosts = false;
          serverAliveCountMax = 3;
          serverAliveInterval = 0;
          userKnownHostsFile = "~/.ssh/known_hosts";
        };

        # GitHub-specific configuration
        "github.com" = {
          user = "git";
          identityFile = "~/.ssh/id_ed25519";
        };
      };
    };

  };
}
