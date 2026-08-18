# Public flake

The flake is the public integration surface for the reusable Dragonix core.
It exposes a complete Home Manager module plus smaller entry points for CLI,
Nix quality tools, profiles, terminal programs, and the `just` helper.

The checks evaluate three representative Home Manager compositions on Linux and
Darwin architectures:

- `minimal` — Git, fd, jq, ripgrep, and the repository-aware `j` helper.
- `developer` — the minimal baseline plus interactive shell tools, Git delta,
  formatters, shell lint tools, and tmux.
- `terminal` — the minimal baseline plus tmux, Zellij, and WezTerm configuration.

The flake still does not expose real hosts, home configurations, networking,
deployment, or secrets. Those remain private composition concerns.
