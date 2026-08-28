{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../../lib/package-feature.nix {
  namespace = [ "browsing" ];
  namespaceRoot = "programs";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "browser-themes";
  description = "Public reusable browsing capability for browser-themes.";
  packageName = "firefox";
})
  moduleArgs
