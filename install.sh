#!/bin/bash
# Gemini Command Suite - Installation Script
# This script robustly downloads and installs the sps_env command suite into an existing project.

set -e

# --- Configuration ---
REPO_URL="https://github.com/ssuppe/sps_env"
TARGET_DIR=".gemini/commands"
FORCE=false

# --- Helper: Print Error and Exit ---
error_exit() {
    echo "❌ ERROR: $1" >&2
    exit 1
}

# --- Parse Arguments ---
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -f|--force) FORCE=true ;;
        *) error_exit "Unknown parameter: $1" ;;
    esac
    shift
done

echo "🔍 Starting Gemini Command Suite installation..."

# 1. Dependency Check
if ! command -v git >/dev/null 2>&1; then
    error_exit "Git is not installed. Please install git before running this script."
fi

# 2. Check for existing installation
if [ -d "$TARGET_DIR" ]; then
    if [ "$FORCE" = false ]; then
        echo "⚠️  Existing commands found at $TARGET_DIR"
        echo "To overwrite, run the script with the -f or --force flag."
        exit 2  # Specific exit code for "already exists"
    else
        echo "🗑️  Force flag detected. Overwriting existing commands..."
    fi
fi

# 3. Create Temporary Directory with Cleanup Trap
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

# 4. Download
echo "📥 Fetching latest commands from GitHub..."
if ! git clone --depth 1 "$REPO_URL" "$TEMP_DIR" --quiet; then
    error_exit "Failed to clone repository. Check your internet connection or the repository URL."
fi

# 5. Install
echo "🚚 Installing commands to $TARGET_DIR..."
mkdir -p "$TARGET_DIR"

# Copy files while preserving directory structure
if ! cp -r "$TEMP_DIR/.gemini/commands/"* "$TARGET_DIR/"; then
    error_exit "Failed to copy files to $TARGET_DIR."
fi

echo "✨ Installation complete!"
echo "📂 Commands available in $TARGET_DIR"
echo "👉 RECOMMENDED: Run '/setup' to initialize your project structure."
