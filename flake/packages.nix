# expose packages
# flake part module for packages defined with callPackage
{
  inputs,
  self,
  ...
}:
{
  perSystem ={
    pkgs,
    lib,
    system,
    ...
  }:
  let
    nameOf = x: builtins.unsafeDiscardStringContext (lib.removeSuffix ".nix" (builtins.baseNameOf x));
  in
  {
    packages = lib.mkMerge (map (x : {${nameOf x} = pkgs.callPackage x {};}) (inputs.import-tree.leaves (self + "/packages")));
  };
}
