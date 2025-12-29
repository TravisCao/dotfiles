# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository containing development environment configurations for a PhD student focused on research prototypes. The repository manages shell configurations, terminal multiplexing, and Claude Code settings across different machines.

## Key Commands

### Installation and Setup
```bash
# Full installation (installs dependencies and sets up symlinks)
./install.sh

# Sync changes to remote repository
./sync.sh ["custom commit message"]
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

### Directory Structure
- **shell/**: Shell configurations (zsh, bash)
  - `zshrc`: Main zsh configuration with Oh My Zsh setup
  - `bashrc`: Bash fallback configuration
  - `zshrc.local.example`: Template for machine-specific settings
- **tmux/**: Terminal multiplexer configuration
  - `tmux.conf`: Tmux settings and key bindings
- **git/**: Git version control configuration
  - `gitconfig`: Global git configuration with aliases and settings
  - `gitignore_global`: Global gitignore patterns for research projects
- **claude/**: Claude Code configurations and extensions
  - `CLAUDE.md`: Global development guidelines (research-focused)
  - `settings.json`: Claude Code settings with model preferences
  - `agents/`: Specialized agent configurations
  - `commands/`: Custom Claude Code commands
  - `shell-snapshots/`: Shell session snapshots
  - `todos/`: Task tracking data

### Key Design Principles

**Machine-Specific Customization**: The dotfiles support local overrides through `~/.zshrc.local` files that are git-ignored, allowing machine-specific paths, aliases, and environment variables without affecting the shared configuration.

**Symlink-Based Installation**: Uses symbolic links to maintain live connections between the repository and actual configuration files, enabling easy updates and version control.

**Auto-Installation Dependencies**: The install script automatically handles missing dependencies (zsh, Oh My Zsh, fzf) with platform detection for macOS and Linux.

**Backup Safety**: Automatically creates timestamped backups of existing configurations before installation.

### Configuration Management

**Shell Environment**: 
- Uses Oh My Zsh with robbyrussell theme
- Configures NODE_OPTIONS for memory limits (Pylance compatibility)
- Supports both interactive and non-interactive usage
- Loads machine-specific configurations from `~/.zshrc.local`

**Git Configuration**:
- Clean, minimal configuration without aliases
- Global gitignore covering common research files (data, logs, checkpoints)  
- VS Code integration for merge and diff tools
- GitHub CLI credential management
- Rebase-based pull strategy and auto-setup remote branches

**Claude Integration**:
- Configured for research prototype development
- Uses "opusplan" model with specific permissions
- Custom status line with ccstatusline
- Extensive agent and command configurations for development workflows

## Development Workflow

This repository follows a PhD student's research-focused development approach:
- Prioritizes rapid prototyping over production-grade code
- Emphasizes reproducibility and clear documentation
- Uses version control with meaningful commits
- Supports machine-specific configurations through local override files
- Automated syncing to remote repository for backup and sharing

## Important Notes

- The repository is designed for research environments, not production systems
- Local override files (`.zshrc.local`) should be used for sensitive or machine-specific configurations
- The sync script automatically commits and pushes changes to maintain backup
- Claude Code configurations include specialized agents for different development tasks