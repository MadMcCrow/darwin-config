# list of hosts
{ self, ... }: {
  # default apple silicon config
  "apple-silicon" = {
    platform = "aarch64-darwin";
  };
  "intel" = {
    platform = "x86_64-darwin";
  };
  # MBA2020
  "foundry" = {
    modules = [
      self.darwinModules.default
      {
        "x86_64-linux-builder".bootstrap = false;
      }
    ];
  };
}
