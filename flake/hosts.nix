# main darwin configuration for default host
{
  inputs,
  self,
  lib,
  ...
}:
let
  mkHost = { name, platform ? "aarch64-darwin" } : {
    ${name} = inputs.nix-darwin.lib.darwinSystem {
      specialArgs.pkgs = import inputs.nixpkgs {system = platform;};
        modules = (lib.attrValues self.darwinModules) ++ [ {
          nixpkgs.hostPlatform = platform;
        } ];
      };
  };
in
{
  flake.darwinConfigurations = lib.mkMerge (map mkHost (import (self + "/hosts")));
}
