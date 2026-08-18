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

Every feature is opt-in. Feature modules expose ordinary Home Manager options
and accept extension points such as `extraPackages`, aliases, or extra terminal
configuration. The private Dragonix configuration can import the public
default module and add private values around it.

The public API intentionally does not model a real person, machine, network,
secret store, deployment target, or private repository path.
