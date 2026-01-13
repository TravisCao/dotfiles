#!/bin/bash

# Dotlink - Auto-scan and create symlinks for dotfiles
# Usage: ./dotlink.sh [--dry-run]

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
DRY_RUN=false
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

[ "$1" = "--dry-run" ] && DRY_RUN=true

# Mapping: dotfiles_path -> target_path
# Format: "source:target"
declare -a LINK_MAP=(
    # Shell - ZDOTDIR architecture
    # ~/.zshenv sets ZDOTDIR, then zsh reads .zshrc from ~/dotfiles/shell/
    "shell/.zshenv:$HOME/.zshenv"
    "shell/bashrc:$HOME/.bashrc"
    # Tmux
    "tmux/tmux.conf:$HOME/.tmux.conf"
    # Git
    "git/gitconfig:$HOME/.gitconfig"
    "git/gitignore_global:$HOME/.gitignore_global"
    # Claude
    "claude/CLAUDE.md:$HOME/.claude/CLAUDE.md"
    "claude/agents:$HOME/.claude/agents"
    "claude/commands:$HOME/.claude/commands"
    "claude/skills:$HOME/.claude/skills"
    # Codex
    "codex/config.toml:$HOME/.codex/config.toml"
    "codex/skills:$HOME/.codex/skills"
    # Ghostty
    "ghostty/config:$HOME/.config/ghostty/config"
)

backup_created=false

link_file() {
    local source="$DOTFILES_DIR/$1"
    local target="$2"

    # Skip if source doesn't exist
    if [ ! -e "$source" ]; then
        echo "Skip: $1 (not found)"
        return
    fi

    # Check if already correctly linked
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        echo "[ok] $1 -> $target"
        return
    fi

    if $DRY_RUN; then
        echo "Would link: $1 -> $target"
        return
    fi

    # Create parent directory
    mkdir -p "$(dirname "$target")"

    # Backup existing file/dir (not symlink)
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        if ! $backup_created; then
            mkdir -p "$BACKUP_DIR"
            backup_created=true
        fi
        echo "Backup: $target -> $BACKUP_DIR/"
        mv "$target" "$BACKUP_DIR/"
    fi

    # Remove existing symlink if points elsewhere
    [ -L "$target" ] && rm "$target"

    # Create symlink
    ln -sf "$source" "$target"
    echo "Linked: $1 -> $target"
}

echo "Scanning dotfiles..."
$DRY_RUN && echo "(dry-run mode)"
echo ""

for entry in "${LINK_MAP[@]}"; do
    source="${entry%%:*}"
    target="${entry#*:}"
    link_file "$source" "$target"
done

# Set global gitignore
if ! $DRY_RUN; then
    git config --global core.excludesfile ~/.gitignore_global 2>/dev/null || true
fi

echo ""
if $backup_created; then
    echo "Backups saved to: $BACKUP_DIR"
fi
echo "Done!"
$DRY_RUN && echo "Run without --dry-run to apply changes"
