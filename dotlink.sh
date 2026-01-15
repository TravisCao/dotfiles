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
    # Git - local includes shared (like ZDOTDIR pattern)
    # ~/.gitconfig is local, includes ~/dotfiles/git/gitconfig
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

# Setup local gitconfig (like ZDOTDIR pattern for zshrc)
setup_local_gitconfig() {
    local gitconfig="$HOME/.gitconfig"
    local shared_config="$DOTFILES_DIR/git/gitconfig"

    # Remove old symlink if exists (only if it points to our shared config)
    if [ -L "$gitconfig" ]; then
        local symlink_target=$(readlink "$gitconfig")
        if [[ "$symlink_target" == *"dotfiles/git/gitconfig"* ]]; then
            echo "Migrating gitconfig from symlink to local+include..."
            rm "$gitconfig"
        else
            echo "WARNING: ~/.gitconfig is a symlink to: $symlink_target"
            echo "         Expected it to point to dotfiles/git/gitconfig"
            echo "         Please manually migrate this configuration."
            return 1
        fi
    fi

    # Create local gitconfig if not exists
    if [ ! -f "$gitconfig" ]; then
        echo "Creating local ~/.gitconfig..."
        cat > "$gitconfig" << EOF
# Local git config - machine-specific, not tracked by git
# Tools will auto-write here (gh, etc.)

[include]
    path = ~/dotfiles/git/gitconfig

# Machine-specific settings below
EOF
        echo "[ok] Created ~/.gitconfig with include"
    else
        # Check if include already exists using git config parser
        if ! git config -f "$gitconfig" --get-all include.path 2>/dev/null | grep -q "dotfiles/git/gitconfig"; then
            echo "Adding include to existing ~/.gitconfig..."

            # Warn about potential conflicts
            echo ""
            echo "WARNING: Existing ~/.gitconfig will be merged with shared config."
            echo "         Settings AFTER [include] override shared config."
            echo "         Review ~/.gitconfig to remove duplicates of:"
            echo "           - [user] name/email"
            echo "           - [core] editor/pager"
            echo ""

            # Prepend include to existing config
            local temp_file=$(mktemp)
            cat > "$temp_file" << EOF
# Local git config - machine-specific, not tracked by git

[include]
    path = ~/dotfiles/git/gitconfig

# Settings below override shared config
EOF
            cat "$gitconfig" >> "$temp_file"
            mv "$temp_file" "$gitconfig"
            echo "[ok] Added include to ~/.gitconfig"
        else
            echo "[ok] ~/.gitconfig already has include"
        fi
    fi
}

if ! $DRY_RUN; then
    setup_local_gitconfig
fi

echo ""
if $backup_created; then
    echo "Backups saved to: $BACKUP_DIR"
fi
echo "Done!"
$DRY_RUN && echo "Run without --dry-run to apply changes"
