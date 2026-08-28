# Module catalog

The public API has two layers: small feature modules for selective composition,
and profiles for a fast starting point.

| Entry point | Main options | Purpose |
| --- | --- | --- |
| `modules/dragonix` | — | Import the complete public module set. |
| `modules/profiles` | `dragonix.profiles.minimal.enable` | Git, fd, jq, ripgrep, and `j`. |
| `modules/profiles` | `dragonix.profiles.developer.enable` | Minimal plus interactive CLI tools, quality tools, delta, and tmux. |
| `modules/profiles` | `dragonix.profiles.terminal.enable` | Minimal plus interactive CLI tools and tmux. |
| `modules/programs/cli/essentials.nix` | `extraPackages` | Portable command-line baseline and Git defaults. |
| `modules/programs/cli/interactive.nix` | `aliases` | bat, eza, fzf, zoxide, direnv, Starship, and tealdeer. |
| `modules/programs/cli/development.nix` | `extraPackages`, `gitDelta.enable` | `just`, Nix formatting, shell linting, shell formatting, and delta. |
| `modules/programs/cli/just` | `enable` | Repository-aware `j` wrapper around `just`. |
| `modules/programs/nix` | `extraPackages` | Standalone Nix and shell quality-tool feature. |
| `modules/programs/terminal/tmux.nix` | `prefix`, `extraConfig` | Practical tmux defaults with per-user extension points. |
| `modules/programs/terminal/zellij.nix` | `extraConfig` | Small, non-invasive Zellij configuration. |
| `modules/programs/terminal/wezterm.nix` | `extraConfig` | Small, non-invasive WezTerm configuration. |

## Compose features directly

Profiles are convenience defaults, not a required abstraction. A private or
public Home Manager configuration can import the default module and select only
the capabilities it wants:

```nix
{
  imports = [ inputs.dragonix-public.homeManagerModules.default ];

  dragonix.features.programs.cli.essentials = {
    enable = true;
    extraPackages = [ pkgs.ripgrep-all ];
  };

  dragonix.features.programs.terminal.tmux = {
    enable = true;
    prefix = "C-space";
  };
}
```

The modules do not choose a host, username, home directory, shell, network,
secret backend, or deployment target. Those values remain composition inputs.

Some capabilities intentionally provide a portable runtime dependency rather
than an absent integration: `browser-runtime` provides Chromium for browser
automation, `telemetry-json` provides `jq` for JSON inspection, and
`lua-for-hammerspoon` provides Lua for authoring external Hammerspoon
configuration. Their names and generated aliases do not claim to install or
configure those external integrations.
