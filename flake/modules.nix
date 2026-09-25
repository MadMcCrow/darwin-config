# build the darwinModules flake output
{
  self,
  inputs,
  lib,
  ...
}:
let
  nameOf = x: builtins.unsafeDiscardStringContext (lib.removeSuffix ".nix" (builtins.baseNameOf x));
in
{
  flake.darwinModules = lib.mkMerge (map (x: {
     ${nameOf x} = import x;
  }) inputs.import-tree.leaves ( self + "/modules"));
}
