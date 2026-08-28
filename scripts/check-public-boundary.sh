#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# .gitrepo is git-subrepo bookkeeping for the monorepo checkout, not public
# source. It is validated as metadata here and must be removed by any
# standalone export before publication.
if [[ -f "$repo_root/.gitrepo" ]] && ! awk '
  /^;/ { next }
  NF == 0 { next }
  $1 == "[subrepo]" { section = 1; next }
  section && $1 ~ /^(remote|branch|commit|method|cmdver)$/ && $2 == "=" { next }
  { bad = 1 }
  END { exit bad }
' "$repo_root/.gitrepo"; then
  printf 'Public-boundary scan found unexpected .gitrepo metadata.\n' >&2
  exit 1
fi

if matches="$({
  rg -n -S --hidden \
    --glob '!.git/**' \
    --glob '!.gitrepo' \
    -e "$(printf '%s%s' nikhil maddirala)" \
    -e "$(printf '%s%s' ver max)" \
    -e "$(printf '%s%s' sheep stealer)" \
    -e "$(printf '%s%s' dream fyre)" \
    -e "$(printf '%s%s' infi sical)" \
    -e "$(printf '%s%s' dop pler)" \
    -e "$(printf 'not%s' es/)" \
    -e "$(printf '/run/%s' secrets)" \
    -e '(api[_-]?key|password|credential|token)[[:space:]]*=' \
    -e '(AKIA[0-9A-Z]{16}|gh[pousr]_[A-Za-z0-9_]+|sk-[A-Za-z0-9_-]{20,})' \
    "$repo_root" || true
} )"; [[ -n "$matches" ]]; then
  printf 'Public-boundary scan found private identifiers:\n%s\n' "$matches" >&2
  exit 1
fi

manifest="$repo_root/docs/module-manifest.tsv"
source_inventory="$repo_root/docs/source-inventory.tsv"
if [[ ! -f "$repo_root/LICENSE" || ! -f "$manifest" || ! -f "$source_inventory" ]]; then
  printf 'Public-boundary scan requires LICENSE, module-manifest.tsv, and source-inventory.tsv.\n' >&2
  exit 1
fi

module_count="$(find "$repo_root/modules" -type f -name '*.nix' | wc -l)"
manifest_count="$(tail -n +2 "$manifest" | awk 'NF { count++ } END { print count + 0 }')"
if [[ "$module_count" -ne "$manifest_count" ]]; then
  printf 'Public module manifest count mismatch: %s files, %s rows.\n' \
    "$module_count" "$manifest_count" >&2
  exit 1
fi

if ! awk -F '\t' '
  NF == 0 { next }
  NR == 1 { next }
  NF != 7 { bad = 1; next }
  ($1 == "" || $2 == "" || $3 == "" || $4 == "" || $5 == "" || $6 == "" || $7 == "") { bad = 1; next }
  ($2 !~ "^modules/.*[.]nix$") { bad = 1; next }
  ($1 != "N/A (new public module)" && $1 !~ /^\.\//) { bad = 1; next }
  seen[$2]++
  END {
    for (path in seen) if (seen[path] != 1) bad = 1
    exit bad
  }
' "$manifest"; then
  printf 'Public module manifest has malformed rows.\n' >&2
  exit 1
fi

while IFS=$'\t' read -r source destination _; do
  [[ -z "$destination" ]] && continue
  [[ "$destination" == destination ]] && continue
  if [[ ! -f "$repo_root/$destination" ]]; then
    printf 'Public module manifest references missing path: %s\n' "$destination" >&2
    exit 1
  fi
  if [[ "$source" == ./* && ! -f "$repo_root/${source#./}" ]]; then
    printf 'Public module manifest references missing source: %s\n' "$source" >&2
    exit 1
  fi
done < "$manifest"

if ! awk -F '\t' '
  NF == 0 { next }
  NR == 1 {
    if ($0 != "source_scope\tclassification\towner\tdependency\tlicense\tredistribution\tdecision") bad = 1
    next
  }
  NF != 7 { bad = 1; next }
  ($1 == "" || $2 == "" || $3 == "" || $4 == "" || $5 == "" || $6 == "" || $7 == "") { bad = 1; next }
  ($2 != "retained" && $2 != "rewritten" && $2 != "excluded") { bad = 1 }
  ($5 != "authored-mit" && $5 != "upstream-package-license" && $5 != "private-only") { bad = 1 }
  ($6 != "allowed" && $6 != "not-redistributed" && $6 != "requires-review") { bad = 1 }
  ($2 == "excluded" && $6 != "not-redistributed") { bad = 1 }
  ($2 != "excluded" && $6 == "not-redistributed") { bad = 1 }
  seen[$1]++
  END {
    for (path in seen) if (seen[path] != 1) bad = 1
    exit bad
  }
' "$source_inventory"; then
  printf 'Public source inventory has malformed or unconstrained rows.\n' >&2
  exit 1
fi

for scope in \
  'private/modules/programs/**' \
  'private/modules/system/**' \
  'private/modules/profiles/**' \
  'private/modules/base/secrets/**' \
  'private/modules/programs/dragonix-agents/**' \
  'private/modules/**/source.nix' \
  'private/hosts/**' \
  'private/home/**'; do
  if ! awk -F '\t' -v expected="$scope" 'NR > 1 && $1 == expected { found = 1 } END { exit !found }' "$source_inventory"; then
    printf 'Public source inventory is missing required scope: %s\n' "$scope" >&2
    exit 1
  fi
done

if find "$repo_root" -type d \( -name .direnv -o -name result -o -name 'result-*' \) -print -quit | rg -q .; then
  printf 'Public-boundary scan found generated state.\n' >&2
  exit 1
fi

printf 'Public-boundary, provenance, and redistribution checks passed.\n'
