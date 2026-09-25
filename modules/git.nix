# darwin system configuration for git
{
  pkgs,
  self,
  ...
}:
{
  # Build darwin flake using:
  # $ darwin-rebuild build --flake .#default
  flake.darwinModules."git" = {
    # add a global "macOS" gitignore
    environment.etc."git/.gitignore".text = ''
      *~
      .*.swp
      .DS_Store
    '';
    # set config file
    environment.etc."git/config".text = ''
      [core]
         	ignorecase = false
         	excludesfile = /etc/git/.gitignore
      [help]
          autocorrect = 1
      [color]
          ui = true
    '';
    # set git config environment variable
    environment.variables = {
      "GIT_CONFIG" = "/etc/git/config";
    };
  };
}
