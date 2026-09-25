# auto updater tool.
# TODO :
# - use a just recipe for better scripting and fzf TUI
# - detect system vs hostname in --flake
# - use npins for auto version bump
{
  lib,
  writeShellApplication,
  system,
  nix,
  just,
  npins,
  darwin,
  ...
}:
let
  repo = "github:MadMcCrow/darwin-config";
in
writeShellApplication {
  name = "darwin-update";
  runtimeInputs = [
    nix
    just
  ];
  text = ''
    sudo darwin-rebuild --flake ${repo}#${system} switch
  '';
}
