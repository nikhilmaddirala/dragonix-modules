{ config, lib, ... }:
let
  cfg = config.dragonix.features.programs.terminal.tmux;
in
{
  options.dragonix.features.programs.terminal.tmux = {
    enable = lib.mkEnableOption "a practical tmux configuration";

    prefix = lib.mkOption {
      type = lib.types.str;
      default = "C-a";
      description = "tmux prefix key.";
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Additional tmux configuration appended to the public defaults.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      escapeTime = 0;
      historyLimit = 10000;
      keyMode = "vi";
      mouse = true;
      prefix = cfg.prefix;
      terminal = "tmux-256color";

      extraConfig = ''
        set -g renumber-windows on
        set -g status-position top
        set -g focus-events on
        set -g set-clipboard on
        set -g allow-passthrough on
        set -ga terminal-overrides ",'*256col*:Tc'"

        bind c new-window -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
        bind '"' split-window -v -c "#{pane_current_path}"
        bind r source-file ~/.config/tmux/tmux.conf \; display-message "tmux configuration reloaded"

        ${cfg.extraConfig}
      '';
    };
  };
}
