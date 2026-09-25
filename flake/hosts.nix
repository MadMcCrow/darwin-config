# main darwin configuration for default host
args@{
  inputs,
  self,
  lib,
  ...
}:
let
  # this flake modules
  myModules = lib.attrValues self.darwinModules;

  # helper lambda
  mkHost =
    name:
    {
      platform ? "aarch64-darwin",
      modules ? [ self.darwinModules.default ],
      ...
    }:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        pkgs = import inputs.nixpkgs {
          system = platform;
        };
        inherit inputs self;
      }
      // inputs;
      modules = modules ++ [
        {
          nixpkgs.hostPlatform = platform;
        }
      ];
    };
in
{
  flake.darwinConfigurations = builtins.mapAttrs mkHost (import (self + "/hosts") args);
}
