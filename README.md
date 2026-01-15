# Dotfiles

Personal configuration files for development environment.

## Contents

- **shell/**: Zsh configurations (ZDOTDIR architecture)
- **tmux/**: Tmux configuration
- **git/**: Git configuration and global gitignore
- **claude/**: Claude Code settings and global instructions

## Installation

```bash
git clone https://github.com/TravisCao/dotfiles.git ~/dotfiles
cd ~/dotfiles
./init.sh
```

## Architecture

This dotfiles uses **local-includes-shared** pattern to separate shared and local configurations:

### Shell (ZDOTDIR)

```
~/.zshenv          -> ~/dotfiles/shell/.zshenv (sets ZDOTDIR)
                          |
                          v
~/dotfiles/shell/.zshrc   (shared config, git-tracked)
                          |
                          v
~/.zshrc                  (local config, NOT git-tracked)
```

### Git

```
~/.gitconfig              (local config, NOT git-tracked)
    |
    | [include] path = ~/dotfiles/git/gitconfig  <- loaded first
    | [credential] ...                            <- overrides shared
    v
~/dotfiles/git/gitconfig  (shared config, git-tracked)
```

**Benefits**:
- Tools that auto-modify configs write to local files, not polluting shared config
- Shared config stays clean and syncs across machines via git
- No merge conflicts between machines
- Settings after `[include]` in local config override shared settings

## Machine-Specific Configuration

Local configurations are created automatically by `init.sh`:

### Shell (`~/.zshrc`)

```bash
# Example ~/.zshrc (local)

# Homebrew (Linux)
[ -d /home/linuxbrew/.linuxbrew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Gurobi solver
export GUROBI_HOME=/opt/gurobi1201/linux64
export PATH="$GUROBI_HOME/bin:$PATH"

# Custom aliases
alias myproject="cd /path/to/my/project"
```

### Git (`~/.gitconfig`)

```ini
# Example ~/.gitconfig (local)

[include]
    path = ~/dotfiles/git/gitconfig

# Credential helper (machine-specific path)
[credential "https://github.com"]
    helper = !/opt/homebrew/bin/gh auth git-credential
```

These files are:
- Automatically created/sourced by init.sh
- NOT tracked by git
- Safe for tools to auto-modify (gh, bun, nvm, etc.)

## Syncing

```bash
# Push local changes
~/dotfiles/sync.sh push "commit message"

# Pull remote updates
~/dotfiles/sync.sh pull
```

Shell startup automatically detects:
- Local uncommitted changes
- Remote updates available

## Migration from Old Setup

If you have an existing symlink-based setup, `init.sh` will automatically:
1. Remove old `~/.zshrc` symlink
2. Move `~/.zshrc.local` to `~/.zshrc`
3. Create `~/.zshenv` symlink

## Backup

The install script automatically creates backups of existing files in `~/.dotfiles_backup_<timestamp>/`.
