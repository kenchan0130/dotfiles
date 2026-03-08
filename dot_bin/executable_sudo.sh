#!/bin/zsh

set -euo pipefail

SRC=/etc/pam.d/sudo_local.template
DST=/etc/pam.d/sudo_local

if [ ! -f "$SRC" ]; then
  echo "Error: $SRC not found" >&2
  exit 1
fi

if [ -f "$DST" ]; then
  echo "Error: $DST already exists" >&2
  exit 1
fi

sed 's/^#\(auth.*sufficient.*pam_tid\.so\)$/\1/' "$SRC" | sudo tee "$DST" >/dev/null
echo "Created $DST with pam_tid.so enabled"