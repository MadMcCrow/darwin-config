# darwin system configuration for git
{ pkgs, ... }: {
  config = {
    # add a global "macOS" gitignore
    environment = {
      etc."git/.gitignore".text = ''
        *~
        .*.swp
        .DS_Store
      '';
      # set config file
      etc."git/config".text = ''
        [core]
           	ignorecase = false
           	excludesfile = /etc/git/.gitignore
        [help]
            autocorrect = 1
        [color]
            ui = true
      '';
      # set git config environment variable
      variables = {
        "GIT_CONFIG" = "/etc/git/config";
      };
    };
  };
}
