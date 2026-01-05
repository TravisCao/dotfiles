#!/bin/bash

# Dotfiles initialization script
# Usage: ./init.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Initializing dotfiles..."

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
else
    OS="linux"
    sudo apt update
fi

echo "Detected OS: $OS"

# Install zsh if not present
if ! command -v zsh &> /dev/null; then
    echo "Installing zsh..."
    if [[ "$OS" == "macos" ]]; then
        brew install zsh
    else
        sudo apt install -y zsh
    fi
fi

# Make zsh the default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting zsh as default shell..."
    chsh -s "$(which zsh)"
    echo "zsh set as default shell. Please restart your terminal."
fi

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install CLI tools
echo "Installing CLI tools..."

if [[ "$OS" == "macos" ]]; then
    TOOLS="fzf zoxide lsd lazygit fd bat atuin git-delta"
    for tool in $TOOLS; do
        if ! brew list "$tool" &>/dev/null; then
            echo "  Installing $tool..."
            brew install "$tool"
        else
            echo "  [ok] $tool"
        fi
    done
else
    # Ubuntu/Debian - use apt where possible
    echo "  Installing apt packages..."
    sudo apt install -y fzf fd-find bat curl unzip lsd git-delta zoxide software-properties-common

    # lazygit (requires PPA)
    if ! command -v lazygit &>/dev/null; then
        echo "  Installing lazygit via PPA..."
        sudo add-apt-repository -y ppa:lazygit-team/release
        sudo apt update
        sudo apt install -y lazygit
    else
        echo "  [ok] lazygit"
    fi

    # atuin (use snap for reliability)
    if ! command -v atuin &>/dev/null; then
        echo "  Installing atuin via snap..."
        sudo snap install atuin
    else
        echo "  [ok] atuin"
    fi
fi

# Create symlinks using dotlink.sh
echo ""
"$DOTFILES_DIR/dotlink.sh"

# Set global gitignore
git config --global core.excludesfile ~/.gitignore_global

echo ""
echo "Dotfiles initialization completed!"
echo "Please restart your shell or run 'source ~/.zshrc' to apply changes"
