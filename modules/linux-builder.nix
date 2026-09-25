# support for developping this flake on darwin
{
  pkgs,
  lib,
  config,
  nix-rosetta-builder,
  ...
}:
let
  cfg = config."x86_64-linux-builder";
  apple-silicon = with pkgs.stdenv.hostPlatform; isAarch64 && isDarwin;
in
{
  options."x86_64-linux-builder" = lib.optionalAttrs apple-silicon {
    # enable = lib.mkEnableOption "build linux x86_64 with Rosetta on apple silicon";
    bootstrap = lib.mkOption {
      description = ''
        An existing Linux builder is needed to initially bootstrap `nix-rosetta-builder`.
        If one isn't already available: set bootstrap to true;
        and run `darwin-rebuild switch` a twice ( in between, reset to false).
        Subsequently, `nix-rosetta-builder` can rebuild itself.
      '';
      default = false;
    };
  };

  imports = [ nix-rosetta-builder.darwinModules.default ];
  config = lib.mkMerge [
    (lib.mkIf apple-silicon {
      #  prerequisites
      nix.settings = {
        trusted-users = [ "@admin" ];
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };

      nix-rosetta-builder = {
        enable = !cfg.bootstrap;
        onDemand = true;
      };

      nix.linux-builder = {
        # inherit package;
        enable = cfg.bootstrap;
        ephemeral = true;
      };
    })
    # x86 can already build linux x86 with just a VM ;)
    (lib.mkIf (!apple-silicon) {
      nix.linux-builder.enable = true;
    })
  ];
}
