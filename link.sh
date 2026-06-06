#!/bin/bash
# sps_env - Skill Symlinking Script
# Usage: Run this script from the root of the project where you want to use the skills.
# Example:
#   cd ../myproject
#   bash /home/clark/dev/sps_env/link.sh

set -e

# Get the source directory where this script is located
SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SRC_SKILLS_DIR="$SRC_DIR/.agents/skills"

# Check if we are running in the source directory itself
if [ "$PWD" = "$SRC_DIR" ]; then
    echo "❌ Error: Do not run this script from the sps_env repository itself."
    echo "Please cd to your target project directory first, e.g.:"
    echo "  cd ../myproject"
    echo "  bash $SRC_DIR/link.sh"
    exit 1
fi

echo "🔗 Symlinking sps_env skills into $(pwd)..."

# Ensure the target directory exists
TARGET_SKILLS_DIR=".agents/skills"
mkdir -p "$TARGET_SKILLS_DIR"

# Loop through each skill in the source skills directory
for skill_path in "$SRC_SKILLS_DIR"/sps-*; do
    if [ -d "$skill_path" ]; then
        skill_name=$(basename "$skill_path")
        target_path="$TARGET_SKILLS_DIR/$skill_name"
        
        # Check if the target already exists (either as a symlink or normal folder/file)
        if [ -e "$target_path" ] || [ -L "$target_path" ]; then
            echo "⚠️  $target_path already exists. Skipping."
        else
            ln -s "$skill_path" "$target_path"
            echo "✅ Linked $skill_name"
        fi
    fi
done

echo "✨ Symlinking complete!"
