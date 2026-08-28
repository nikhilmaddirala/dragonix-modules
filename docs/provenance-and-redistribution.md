# Provenance and redistribution

The public module tree is a curated extraction from Dragonix's reusable
program, desktop, terminal, and system behavior. The source inventory is
recorded in [`module-manifest.tsv`](module-manifest.tsv), one row per Nix
module, with its public owner, configuration class, dependency set, and
validation surface. The private-source classification inventory is recorded
separately in [`source-inventory.tsv`](source-inventory.tsv); it accounts for
the reusable module families considered for extraction and explicitly records
which private-only families are excluded.

The extracted modules are authored configuration code and are distributed under
the repository's MIT license. Package names refer to upstream Nixpkgs
artifacts; this repository does not redistribute those package sources or
vendor their licenses. New code or vendored assets require a manifest update,
an owner, and a redistribution review before inclusion.

The manifests are audit contracts, not generated mirrors. The boundary check
enforces their headers, row classifications, license values, and
redistribution decisions. Private host adapters,
personal identities, local paths, credentials, network topology, service
instances, and deployment policy are intentionally excluded. The private
Dragonix configuration remains responsible for composing public capabilities
with those values.
