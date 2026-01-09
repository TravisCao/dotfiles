#!/bin/bash

# Dotfiles sync script
# Usage: ./sync.sh [push|pull] [message]

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"

ACTION="${1:-push}"

case "$ACTION" in
    check)
        # Check for remote updates (called from zshrc)
        git fetch origin --quiet 2>/dev/null || exit 0
        LOCAL=$(git rev-parse HEAD)
        REMOTE=$(git rev-parse @{u} 2>/dev/null) || exit 0
        if [ "$LOCAL" != "$REMOTE" ]; then
            BEHIND=$(git rev-list --count HEAD..@{u} 2>/dev/null)
            [ "$BEHIND" -gt 0 ] && echo "dotfiles: remote has $BEHIND update(s)"
        fi
        ;;
    pull)
        echo "Pulling dotfiles from remote..."
        git pull --rebase
        echo "Dotfiles updated!"
        echo "Run 'source ~/dotfiles/shell/.zshrc' to reload"
        ;;
    push)
        echo "Syncing dotfiles..."

        # Check if there are changes
        if [ -z "$(git status --porcelain)" ]; then
            echo "No changes to sync"
            exit 0
        fi

        # Show changes with delta highlighting
        echo "Changes detected:"
        echo "---"
        git diff --color=always | delta --paging=never
        echo "---"

        # Ask for confirmation
        read -p "Push these changes? [y/N] " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Aborted."
            exit 0
        fi

        # Add all changes
        git add .

        # Commit with message
        commit_msg="${2:-Auto-sync dotfiles $(date '+%Y-%m-%d %H:%M:%S')}"
        git commit -m "$commit_msg"

        # Push to remote if it exists
        if git remote get-url origin &>/dev/null; then
            echo "Pushing to remote..."
            git push
            echo "Dotfiles synced to GitHub!"
        else
            echo "Warning: No remote repository configured."
        fi
        ;;
    *)
        echo "Usage: ./sync.sh [push|pull] [message]"
        echo "  push  - Commit and push local changes (default)"
        echo "  pull  - Pull latest changes from remote"
        exit 1
        ;;
esac
