# Public flake

The flake is the public integration surface for the reusable Dragonix core.
It exposes Home Manager modules plus separate NixOS and Darwin module entry
points. `homeManagerModules.default` is the complete public composition,
`homeManagerModules.core` is the collision-free private-consumer surface, and
smaller outputs cover the public programs, AI, desktop, CLI, Nix quality tools,
profiles, terminal programs, and the `just` helper.

The checks evaluate three representative Home Manager compositions on Linux and
Darwin architectures:

- `minimal` — Git, fd, jq, ripgrep, and the repository-aware `j` helper.
- `developer` — the minimal baseline plus interactive shell tools, Git delta,
  formatters, shell lint tools, and tmux.
- `terminal` — the minimal baseline plus tmux, Zellij, and WezTerm configuration.

The `all-public-capabilities` check enables every curated leaf module once on
each supported system and verifies the public namespace, installed package
effects, and representative command aliases. Platform-specific packages are
skipped when their metadata marks them unavailable for that host.
Separate module-output checks import the public AI and desktop entry points so
advertised directory outputs cannot silently point at missing files.

The flake still does not expose real hosts, home configurations, networking,
deployment, or secrets. Those remain private composition concerns.

The per-module owner, dependency closure, and validation fixture are recorded
in [`../docs/module-manifest.tsv`](../docs/module-manifest.tsv).
