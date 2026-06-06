#!/bin/bash
# Gemini Command Suite - Installation Script
# This script robustly downloads and installs the sps_env command suite into an existing project.

set -e

# --- Configuration ---
REPO_URL="https://github.com/ssuppe/sps_env"
TARGET_DIR=".agents/skills"
FORCE=false
ADD_TO_IGNORE=false

# --- Helper: Print Error and Exit ---
error_exit() {
    echo "❌ ERROR: $1" >&2
    exit 1
}

# --- Parse Arguments ---
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -f|--force) FORCE=true ;;
        -i|--ignore) ADD_TO_IGNORE=true ;;
        *) error_exit "Unknown parameter: $1" ;;
    esac
    shift
done

echo "🔍 Starting Antigravity CLI Skills Suite installation..."

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
echo "🚚 Installing skills to $TARGET_DIR..."
mkdir -p "$TARGET_DIR"

# Copy files while preserving directory structure
if ! cp -r "$TEMP_DIR/.agents/skills/"* "$TARGET_DIR/"; then
    error_exit "Failed to copy files to $TARGET_DIR."
fi

# 6. Gitignore Handling
if [ -f ".gitignore" ]; then
    if grep -q "$TARGET_DIR" ".gitignore"; then
        echo "✅ $TARGET_DIR is already in .gitignore."
    elif [ "$ADD_TO_IGNORE" = true ]; then
        echo "" >> .gitignore
        echo "# Antigravity CLI Skills" >> .gitignore
        echo "$TARGET_DIR" >> .gitignore
        echo "🛡️  Added $TARGET_DIR to .gitignore."
    else
        echo "💡 TIP: You are in a Git repository. If this is a public project,"
        echo "   you may want to add '$TARGET_DIR' to your .gitignore."
        echo "   Run the script with -i or --ignore to do this automatically."
    fi
fi

echo "✨ Installation complete!"
echo "📂 Skills available in $TARGET_DIR"
echo "👉 RECOMMENDED: Run the 'sps-setup' skill to initialize your project structure."
