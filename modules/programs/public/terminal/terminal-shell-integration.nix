{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../../lib/package-feature.nix {
  namespace = [ "terminal" ];
  namespaceRoot = "programs";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "terminal-shell-integration";
  description = "Bash shell integration for terminal sessions.";
  packageName = "bash";
  nativeConfig = {
    programs.bash.enable = true;
  };
})
  moduleArgs
