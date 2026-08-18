{ config, lib, ... }:
let
  cfg = config.dragonix.features.programs.terminal.zellij;
in
{
  options.dragonix.features.programs.terminal.zellij = {
    enable = lib.mkEnableOption "a practical Zellij configuration";

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Additional Zellij KDL configuration.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableBashIntegration = false;
      enableFishIntegration = false;
      enableZshIntegration = false;
      extraConfig = ''
        pane_frames false
        simplified_ui true
        default_layout "compact"

        ${cfg.extraConfig}
      '';
    };
  };
}
