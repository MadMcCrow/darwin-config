# build the darwinModules flake output
{
  self,
  inputs,
  lib,
  ...
}:
let
  nameOf = x: builtins.unsafeDiscardStringContext (lib.removeSuffix ".nix" (builtins.baseNameOf x));
  modules = inputs.import-tree.leaves (self + "/modules");
in
{
  flake.darwinModules = lib.mkMerge (
    [
      {
        "default" = {
          imports = modules;
        };
      }
    ]
    ++ (map (x: {
      ${nameOf x} = import x;
    }) modules)
  );
}
