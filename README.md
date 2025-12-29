# Dotfiles

Personal configuration files for development environment.

## Contents

- **shell/**: Zsh and Bash configurations
- **tmux/**: Tmux configuration
- **git/**: Git configuration and global gitignore
- **claude/**: Claude Code settings and global instructions

## Installation

```bash
git clone https://github.com/TravisCao/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Manual Installation

If you prefer to set up manually:

```bash
# Shell configs
ln -sf ~/dotfiles/shell/zshrc ~/.zshrc
ln -sf ~/dotfiles/shell/bashrc ~/.bashrc

# Tmux config
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

# Git config
ln -sf ~/dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/git/gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

# Claude config
mkdir -p ~/.claude
ln -sf ~/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/dotfiles/claude/settings.json ~/.claude/settings.json
```

## Machine-Specific Configuration

The dotfiles support machine-specific configurations through local override files:

1. **Create your local config file:**
   ```bash
   cp ~/dotfiles/shell/zshrc.local.example ~/.zshrc.local
   ```

2. **Edit `~/.zshrc.local` to add machine-specific settings:**
   - Software paths (e.g., Gurobi, MATLAB)
   - Custom aliases
   - Environment variables
   - Machine-specific PATH additions

3. **Example configurations:**
   ```bash
   # Gurobi solver
   export GUROBI_HOME=/opt/gurobi1201/linux64
   export PATH="$GUROBI_HOME/bin:$PATH"
   
   # Custom aliases
   alias myproject="cd /path/to/my/project"
   ```

The `~/.zshrc.local` file is automatically loaded by the main zshrc and is ignored by git, so you can customize it freely without affecting the shared configuration.

## Backup

The install script automatically creates backups of existing files in `~/.dotfiles_backup_<timestamp>/`.