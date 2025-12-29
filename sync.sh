#!/bin/bash

# Dotfiles sync script
# Usage: ./sync.sh [message]

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"

echo "🔄 Syncing dotfiles..."

# Check if there are changes
if [ -z "$(git status --porcelain)" ]; then
    echo "✅ No changes to sync"
    exit 0
fi

# Show changes
echo "📝 Changes detected:"
git diff --name-only

# Add all changes
git add .

# Commit with message
commit_msg="${1:-Auto-sync dotfiles $(date '+%Y-%m-%d %H:%M:%S')}"
git commit -m "$commit_msg"

# Push to remote if it exists
if git remote get-url origin &>/dev/null; then
    echo "🚀 Pushing to remote..."
    git push
    echo "✅ Dotfiles synced to GitHub!"
else
    echo "⚠️  No remote repository configured. Add with:"
    echo "   git remote add origin https://github.com/TravisCao/dotfiles.git"
    echo "   git push -u origin main"
fi