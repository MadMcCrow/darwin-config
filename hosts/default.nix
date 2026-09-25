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
        modules = (lib.attrValues self.darwinModules) ++ [ {
          nixpkgs.hostPlatform = platform;
        } ];
      };
  };
in
{
  flake.darwinConfigurations = lib.mkMerge ( map mkHost [
    {
      name = "foundry"; # MBA2020
    }
  ]);
}
