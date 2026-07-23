#!/usr/bin/env bash

# rename-safe-ng.sh - Convert filenames to lowercase with hyphens for repo archival compatibility
# Usage: ./rename-safe-ng.sh [OPTIONS] [directory]
# Options:
#   --dry-run, -n    Show what would be renamed (don't actually rename)
#   --help, -h       Show this help message
#
# Transformations applied:
#   - Lowercase all letters
#   - Replace spaces and NTFS-forbidden chars with hyphens
#   - Collapse consecutive hyphens
#   - Trim leading/trailing hyphens

set -euo pipefail

DRY_RUN=false
TARGET_DIR="."

while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run|-n)
            DRY_RUN=true
            shift
            ;;
        --help|-h)
            echo "Usage: $(basename "$0") [--dry-run|-n] [directory]"
            echo ""
            echo "Convert filenames to lowercase with hyphens instead of spaces"
            echo "and removes NTFS-forbidden characters for cross-platform"
            echo "repo/archive compatibility."
            echo ""
            echo "Transformations:"
            echo "  - Lowercase all letters"
            echo "  - Replace spaces and < > : \" / \\ | ? * with hyphens"
            echo "  - Collapse consecutive hyphens"
            echo "  - Trim leading/trailing hyphens"
            echo ""
            echo "Options:"
            echo "  --dry-run, -n    Preview changes without renaming files"
            echo "  --help, -h       Show this help message"
            echo ""
            echo "Examples:"
            echo "  $(basename "$0")                    # Process current directory"
            echo "  $(basename "$0") ./my-project       # Process specific directory"
            echo "  $(basename "$0") --dry-run ./*      # Preview only"
            exit 0
            ;;
        -*)
            echo "Error: Unknown option '$1'" >&2
            echo "Use --help for usage information" >&2
            exit 1
            ;;
        *)
            TARGET_DIR="$1"
            shift
            ;;
    esac
done

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: '$TARGET_DIR' is not a valid directory" >&2
    exit 1
fi

# Prompt the user to confirm the directory choice
read -p "Confirm '$TARGET_DIR' directory? (Y/n): " choice

# Default to "Y" if the user just presses Enter
choice=${choice:-Y}
if [[ "$choice" != [yY] ]]; then
    echo "Aborting; no files changed."
    echo "Consult '--help' for usage details."
    exit 1
fi

cd "$TARGET_DIR"

renamed=0
skipped=0
preview_count=0

shopt -s nullglob dotglob

echo_mode="Rename"
[[ "$DRY_RUN" == true ]] && echo_mode="Preview"

echo "${echo_mode}: Converting filenames in '$(pwd)'..."
echo "---"

for filepath in *; do
    # Skip directories
    [[ -d "$filepath" ]] && continue

    filename=$(basename "$filepath")

    # Generate new name
    #newname=$(echo "$filename" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/-\+/-/g' | sed 's/^-//; s/-$//')
    newname=$(echo "$filename" \
        | tr '[:upper:]' '[:lower:]' \
        | tr '<>:"/\\|?* ' '----------' \
        | sed 's/-\+/-/g' \
        | sed 's/^-//; s/-$//')

    # Skip if name didn't change
    if [[ "$filename" == "$newname" ]]; then
        ((skipped++)) || true
        continue
    fi

    # Guard against empty result after sanitization
    if [[ -z "$newname" ]]; then
        echo "[WARN] Sanitized name is empty for '$filename', skipping"
        ((skipped++)) || true
        continue
    fi

    # Check if target already exists
    if [[ -e "$newname" ]]; then
        echo "[WARN] '$newname' already exists, skipping '$filename'"
        ((skipped++)) || true
        continue
    fi

    if [[ "$DRY_RUN" == true ]]; then
        echo "[DRY-RUN] '$filename' → '$newname'"
        ((preview_count++)) || true
    else
        # Perform the rename
        mv -- "$filename" "$newname"
        echo "[RENAMED] '$filename' → '$newname'"
        ((renamed++)) || true
    fi
done

echo "---"
echo ""
if [[ "$DRY_RUN" == true ]]; then
    echo "Dry-run complete! Would rename: $preview_count | Unchanged: $skipped"
    echo "Run without --dry-run to apply changes."
else
    echo "Done! Renamed: $renamed | Skipped: $skipped"
fi
