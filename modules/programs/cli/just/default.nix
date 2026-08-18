{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.dragonix.features.programs.cli.just;
in
{
  options.dragonix.features.programs.cli.just.enable =
    lib.mkEnableOption "the Dragonix just command-runner helper";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.just
      (pkgs.writeShellScriptBin "j" ''
        set -euo pipefail

        if repo="$(git rev-parse --show-toplevel 2>/dev/null)" \
          && [[ -f "$repo/justfile" ]]; then
          exec just --justfile "$repo/justfile" --working-directory "$repo" "$@"
        fi

        exec just "$@"
      '')
    ];
  };
}
