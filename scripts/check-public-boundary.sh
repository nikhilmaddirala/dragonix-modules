#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if matches="$({
  rg -n -S --hidden \
    --glob '!.git/**' \
    --glob '!**/check-public-boundary.sh' \
    --glob '*.nix' \
    --glob '*.lua' \
    --glob '*.kdl' \
    --glob '*.json' \
    --glob '*.yaml' \
    --glob '*.toml' \
    -e 'nikhilmaddirala' \
    -e 'vermax' \
    -e 'sheepstealer' \
    -e 'dreamfyre' \
    -e 'infisical' \
    -e 'doppler' \
    -e 'notes/' \
    "$repo_root" || true
} )"; [[ -n "$matches" ]]; then
  printf 'Public-boundary scan found private identifiers:\n%s\n' "$matches" >&2
  exit 1
fi

if find "$repo_root" -type d \( -name .direnv -o -name result -o -name 'result-*' \) -print -quit | rg -q .; then
  printf 'Public-boundary scan found generated state.\n' >&2
  exit 1
fi

printf 'Public-boundary scan passed.\n'
