{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../../lib/package-feature.nix {
  namespace = [ "cli" ];
  namespaceRoot = "programs";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "atuin";
  description = "Shell history search and sync client with shell integration.";
  packageName = "atuin";
  nativeConfig = {
    programs.atuin = {
      enable = true;
    };
  };
})
  moduleArgs
