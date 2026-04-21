#!/bin/bash

set -euo pipefail

usage() {
  echo "Usage:"
  echo "  $0 wrap <source_file> <disguised_name>"
  echo "  $0 unwrap <disguised_file> <restored_name>"
  echo "  $0 sha256 <file>"
  exit 1
}

sha256_file() {
  local file="$1"
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$file"
  elif command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$file"
  else
    echo "No SHA-256 tool found."
    exit 1
  fi
}

wrap_file() {
  local src="$1"
  local dst="$2"

  if [ ! -f "$src" ]; then
    echo "Source file not found: $src"
    exit 1
  fi

  cp "$src" "$dst"
  echo "Wrapped:"
  echo "  $src -> $dst"
}

unwrap_file() {
  local src="$1"
  local dst="$2"

  if [ ! -f "$src" ]; then
    echo "Disguised file not found: $src"
    exit 1
  fi

  cp "$src" "$dst"
  echo "Unwrapped:"
  echo "  $src -> $dst"
}

if [ "$#" -lt 2 ]; then
  usage
fi

cmd="$1"
shift

case "$cmd" in
  wrap)
    [ "$#" -eq 2 ] || usage
    wrap_file "$1" "$2"
    ;;
  unwrap)
    [ "$#" -eq 2 ] || usage
    unwrap_file "$1" "$2"
    ;;
  sha256)
    [ "$#" -eq 1 ] || usage
    sha256_file "$1"
    ;;
  *)
    usage
    ;;
esac