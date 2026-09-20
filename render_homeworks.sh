#!/usr/bin/env bash
set -e

# render_homeworks.sh
# Render homework assignments locally for upload to UCLA Bruin Learn (Canvas LMS).
#
# Usage:
#   ./render_homeworks.sh       # Renders all homeworks (1-9)
#   ./render_homeworks.sh 2     # Renders Homework 2 only

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if [ -n "$1" ]; then
  HW_NUM="$1"
  TARGET="homeworks/homework${HW_NUM}.qmd"
  if [ ! -f "$TARGET" ]; then
    echo "Error: File $TARGET does not exist."
    exit 1
  fi
  echo "Rendering $TARGET..."
  quarto render "$TARGET"
  echo "✓ Rendered $TARGET successfully."
else
  echo "Rendering all homework assignments (1 through 9)..."
  for f in homeworks/homework[1-9].qmd; do
    if [ -f "$f" ]; then
      echo "Rendering $f..."
      quarto render "$f"
    fi
  done
  echo "✓ All homeworks rendered successfully."
fi
