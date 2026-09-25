{
  pkgs,
  lib,
  lix,
  darwin,
  ...
}:
darwin.linux-builder.override {
  modules = [
    {
      nix = {
        package = lix;
        settings.experimental-features = ["nix-command" "flakes"];
        # settings.auto-optimise-store = true;
      };
      # expose x86_64-linux
      boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
      # force Apple's vGIC
      virtualisation.qemu.options = [
        "-machine"
        "virt"
      ];
    }
  ];
}
