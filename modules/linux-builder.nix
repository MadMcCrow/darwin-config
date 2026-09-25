# support for developping this flake on darwin
{
  inputs,
  self,
  ...
}:
let
  pkgOverride =
    pkgs:
    pkgs.darwin.linux-builder.override {
      modules = [
        {
          # force Apple's vGIC
          virtualisation.qemu.options = [
            "-machine"
            "virt,gic-version=host"
          ];
        }
      ];
    };
  config = { pkgs, ... }: {
    nix = {
      linux-builder = {
        package = pkgOverride pkgs;
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
      system-features = [
        "nixos-test"
        "apple-virt"
        "gccarch-armv8-a"
      ];
    };
  };
in
{
  perSystem =
    {
      pkgs,
      lib,
      system,
      ...
    }:
    lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      packages = {
        linux-builder = pkgOverride pkgs;
      };
    };

  # modules to expose for nix darwin config
  flake.darwinModules = {
    linux-builder = config;
  };
}
