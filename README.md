# Dragonix Public

Dragonix Public is the reusable, sanitized core of a larger private Nix
configuration. It is a real standalone Home Manager module library rather than
a redacted mirror: private Dragonix can consume these modules, while this
repository remains useful on its own.

## What is included

- A complete `homeManagerModules.default` entry point.
- Composable CLI features for Git, fd, jq, ripgrep, bat, eza, fzf, zoxide,
  direnv, Starship, tealdeer, `just`, Git delta, Nix formatting, and shell
  quality tools.
- Portable tmux, Zellij, and WezTerm modules with documented extension points.
- `minimal`, `developer`, and `terminal` profiles for quick adoption.
- Cross-platform flake checks and standalone example compositions.

Start with:

```nix
{
  inputs.dragonix-public.url = "github:nikhilmaddirala/dragonix-public";

  outputs = { self, nixpkgs, home-manager, dragonix-public, ... }:
    home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      modules = [
        dragonix-public.homeManagerModules.default
        { dragonix.profiles.developer.enable = true; }
      ];
    };
}
```

See [`modules/README.md`](modules/README.md), [`flake/README.md`](flake/README.md),
and [`docs/public-boundary.md`](docs/public-boundary.md) for the module catalog,
validation surface, and publication boundary.

This repository deliberately contains no real host or home configuration,
networking, deployment, secret, agent-estate, or private-repository data.
