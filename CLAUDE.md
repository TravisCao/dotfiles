# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository containing development environment configurations for a PhD student focused on research prototypes. The repository manages shell configurations, terminal multiplexing, and Claude Code settings across different machines using a **ZDOTDIR architecture**.

## Key Commands

### Installation and Setup
```bash
# Full installation (installs dependencies and sets up symlinks)
./init.sh

# Sync changes to remote repository
./sync.sh push ["custom commit message"]

# Pull updates from remote
./sync.sh pull
```

### Development Dependencies
- **zsh**: Primary shell (auto-installed if missing)
- **Oh My Zsh**: Shell framework (auto-installed if missing)
- **fzf**: Fuzzy finder (auto-installed if missing)
- **tmux**: Terminal multiplexer (configuration provided)

### Git Workflow
```bash
# Standard git commands (no custom aliases)
git add .
git commit -m "message"
git push

# Create new branch
git checkout -b branch-name
```

### Testing Python Code (when applicable in other repos)
```bash
# Run Python code
uv run python script.py

# Run specific tests
uv run python -m pytest tests/unit/test_xx.py -v
```

## Architecture and Organization

### ZDOTDIR Architecture

The dotfiles uses **local-includes-shared** pattern to separate shared and local configurations:

**Shell (ZDOTDIR)**:
```
~/.zshenv                   -> symlink to shell/.zshenv (sets ZDOTDIR)
~/dotfiles/shell/.zshrc     -> shared config (git-tracked)
~/.zshrc                    -> local config (NOT git-tracked)
```

**Git**:
```
~/.gitconfig                -> local config (NOT git-tracked)
    [include] path = ...    <- shared config loaded here
    [credential] ...        <- local settings override shared
~/dotfiles/git/gitconfig    -> shared config (git-tracked)
```

**Load order**:
- Shell: `~/.zshenv` -> `$ZDOTDIR/.zshrc` -> `source ~/.zshrc`
- Git: `~/.gitconfig` processes `[include]` first, then local settings override

**Benefits**:
- Tools auto-modifying configs write to local files, not polluting shared config
- No merge conflicts between mac/linux machines
- Clean separation of shared vs machine-specific settings

**IMPORTANT for AI assistants**: When modifying git config, write to `~/.gitconfig` (local), NOT `~/dotfiles/git/gitconfig` (shared). Machine-specific settings like credential helpers belong in local config. Settings placed AFTER `[include]` in local config will override shared config.

### Directory Structure
- **shell/**: Shell configurations (zsh)
  - `.zshenv`: Sets ZDOTDIR (symlinked to ~/.zshenv)
  - `.zshrc`: Main zsh configuration with Oh My Zsh setup
  - `bashrc`: Bash fallback configuration
- **tmux/**: Terminal multiplexer configuration
  - `tmux.conf`: Tmux settings and key bindings
- **git/**: Git version control configuration
  - `gitconfig`: Global git configuration
  - `gitignore_global`: Global gitignore patterns for research projects
- **claude/**: Claude Code configurations and extensions
  - `CLAUDE.md`: Global development guidelines (research-focused)
  - `agents/`: Specialized agent configurations
  - `commands/`: Custom Claude Code commands
  - `skills/`: Custom skills

### Key Design Principles

**Local-Includes-Shared Pattern**: Both shell and git use the same pattern - local config files (NOT tracked) include/source shared config (tracked). This prevents tools from polluting shared config.

**Symlink-Based Installation**: Uses symbolic links for configs that don't support include patterns (tmux, claude).

**Auto-Installation Dependencies**: The init script automatically handles missing dependencies (zsh, Oh My Zsh, fzf) with platform detection for macOS and Linux.

**Automatic Migration**: Running `init.sh` on existing setups automatically migrates from old symlink-based patterns to new local-includes-shared pattern.

### Configuration Management

**Shell Environment**:
- Uses ZDOTDIR to load shared config from `~/dotfiles/shell/`
- Oh My Zsh with robbyrussell theme
- Platform detection for macOS vs Linux
- Local config sourced from `~/.zshrc`
- Sync detection on shell startup (local changes + remote updates)

**Git Configuration**:
- Uses local-includes-shared pattern (`~/.gitconfig` includes `~/dotfiles/git/gitconfig`)
- Shared config: delta, merge/diff tools, pull/push settings
- Local config: credential helpers, machine-specific paths
- Global gitignore covering common research files (data, logs, checkpoints)
- Rebase-based pull strategy

**Claude Integration**:
- Configured for research prototype development
- Extensive agent and command configurations for development workflows

## Development Workflow

This repository follows a PhD student's research-focused development approach:
- Prioritizes rapid prototyping over production-grade code
- Emphasizes reproducibility and clear documentation
- Uses version control with meaningful commits
- Supports machine-specific configurations through `~/.zshrc`
- Automated syncing to remote repository for backup and sharing

## Important Notes

- The repository is designed for research environments, not production systems
- Local configs (`~/.zshrc`, `~/.gitconfig`) should be used for sensitive or machine-specific configurations
- When modifying git settings, write to `~/.gitconfig` (local), not `~/dotfiles/git/gitconfig` (shared)
- The sync script automatically commits and pushes changes to maintain backup
- Shell startup checks for both local changes and remote updates
