#!/usr/bin/env bash
set -euo pipefail

if ! command -v tizen >/dev/null 2>&1; then
  echo "Tizen CLI was not found. Install Tizen Studio with the Web CLI and Samsung TV Extensions."
  exit 1
fi

PROFILE="${TIZEN_PROFILE:-}"
if [[ -z "$PROFILE" ]]; then
  echo "Set TIZEN_PROFILE to the name of your active Samsung TV certificate profile."
  echo "Create the profile in Tizen Studio Certificate Manager first."
  exit 1
fi

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

tizen build-web -- .
tizen package -t wgt -s "$PROFILE" -- .buildResult
echo
echo "Package output:"
find .buildResult -maxdepth 2 -type f -name '*.wgt' -print
