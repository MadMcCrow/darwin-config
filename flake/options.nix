# flake module for options
# define re-useable options for flake-part.
{
  inputs,
  lib,
  ...
}:
{
  options.flake =
    with lib;
    inputs.flake-parts.lib.mkSubmoduleOptions {
      darwinConfigurations = mkOption {
        type = with types; lazyAttrsOf raw;
        default = { };
        description = "Instantiated nix-darwin configurations. Used by `darwin-rebuild`.";
      };
      darwinModules = mkOption {
        type = with types; lazyAttrsOf deferredModule;
        default = { };
        description = "nix-darwin modules, for reuse across configurations.";
      };
    };
}
