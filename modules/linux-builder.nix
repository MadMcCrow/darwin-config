# support for developping this flake on darwin
inputs@{ pkgs, ... }:
let
  package = pkgs.callPackage ./../packages/linux-builder.nix inputs;
in
{
  nix = {
    linux-builder = {
      # inherit package;
      enable = true;
      ephemeral = true;
      # maxJobs = 4;
      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];
      config.boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
      # Force the builder to claim apple-virt and kvm support flags
      supportedFeatures = [
        "kvm"
        "benchmark"
        "big-parallel"
        "nixos-test"
        "apple-virt"
      ];
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    # Explicitly enforce apple-virt as a system feature on the host macOS sides
    # system-features = [
    #  "nixos-test"
    #  "apple-virt"
    #  "gccarch-armv8-a"
    # ];
  };
}
