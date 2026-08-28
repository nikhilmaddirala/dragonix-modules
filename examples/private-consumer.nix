{ ... }:
{
  imports = [ ../modules/public ];

  home.username = "consumer";
  home.homeDirectory = "/home/consumer";
  home.stateVersion = "24.11";

  dragonix.public.features.programs.ai.telemetry-json.enable = true;
  dragonix.public.features.programs.desktop.mpv.enable = true;
}
