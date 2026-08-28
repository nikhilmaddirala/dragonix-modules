{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../lib/package-feature.nix {
  namespace = [ ];
  namespaceRoot = "system";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "login-manager";
  description = "Public reusable system capability for login-manager.";
  packageName = "greetd";
  supportedSystems = [
    "x86_64-linux"
    "aarch64-linux"
  ];
})
  moduleArgs
