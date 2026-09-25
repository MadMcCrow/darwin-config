{ pkgs, lib, darwin, ... } :
  darwin.linux-builder.override {
        modules = [
          {
            # force Apple's vGIC
            virtualisation.qemu.options = [
              "-machine"
              "virt,gic-version=host"
            ];
          }
        ];
  }
