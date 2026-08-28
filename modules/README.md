# Public modules

The public module tree is a reusable Home Manager library. Its modules are
organized by capability, while private Dragonix remains responsible for
choosing hosts, users, machines, secrets, and deployment targets.

## Public entry points

- `modules/dragonix` imports the complete public module set.
- `modules/profiles` provides `minimal`, `developer`, and `terminal` profiles.
- `modules/programs/cli` provides essential, interactive, developer, and `just`
  features.
- `modules/programs/nix` provides portable quality-tool installation.
- `modules/programs/terminal` provides standalone tmux, Zellij, and WezTerm
  modules.
- `modules/programs/public` contains the curated capability modules for the
  CLI, terminal, IDE, AI, browsing, and desktop families.
- `modules/system/public` contains Home Manager-side system extension points;
  `modules/nixos` and `modules/darwin` contain their respective lower-level
  module classes.

The public capability modules use explicit `enable`, `extraPackages`,
`aliases`, and `environment` options. They are inert when disabled and can be
extended by a consuming configuration without importing private Dragonix
paths. Their options live under `dragonix.public.features` so they can compose
with a private Dragonix tree that owns the legacy `dragonix.features` namespace.
See [`../docs/module-manifest.tsv`](../docs/module-manifest.tsv) for source,
destination, ownership, sanitization, and dependencies.

Every feature is opt-in. Feature modules expose ordinary Home Manager options
and accept extension points such as `extraPackages`, aliases, or extra terminal
configuration. The private Dragonix configuration can import the public
default module and add private values around it. The private checkout uses the
`homeManagerModules.core` output to avoid collisions with its legacy options.

The public API intentionally does not model a real person, machine, network,
secret store, deployment target, or private repository path.
