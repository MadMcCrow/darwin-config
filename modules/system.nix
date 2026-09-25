# main darwin system configuration
{ pkgs, self, lib, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      nano
      wget
    ];

    # Necessary for using flakes on this system.
    nix =
      let
        frequency = {
          Hour = 3;
          Minute = 15;
          Day = 1;
        };
      in
      {
        settings.experimental-features = lib.mkDefault ["nix-command" "flakes"];
        gc = {
          automatic = true;
          interval = [ frequency ];
        };
        optimise = {
          automatic = true;
          interval = [ frequency ];
        };
        package = pkgs.lix;
      };

    # Enable alternative shell support in nix-darwin.
    programs = {
      zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableFastSyntaxHighlighting = true;
        # enableFzfCompletion = true;
        enableFzfHistory = true;
      };
      # direnv support for shells
      direnv.enable = true;
    };

    system = {
      # Set Git commit hash for darwin-version.
      configurationRevision = self.rev or self.dirtyRev or null;
      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      stateVersion = 7;
    };
    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";
  };
}
