# main darwin configuration for default host
{
  inputs,
  self,
  lib,
  ...
}:
{
  flake.darwinConfigurations."default" = inputs.nix-darwin.lib.darwinSystem {
    modules = lib.attrValues self.darwinModules;
  };
}
