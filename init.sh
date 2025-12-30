#!/bin/bash

# Dotfiles initialization script
# Usage: ./init.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🔧 Initializing dotfiles..."

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "📥 Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
else
    OS="linux"
    sudo apt update
fi

echo "🖥️  Detected OS: $OS"

# Install zsh if not present
if ! command -v zsh &> /dev/null; then
    echo "📥 Installing zsh..."
    if [[ "$OS" == "macos" ]]; then
        brew install zsh
    else
        sudo apt install -y zsh
    fi
fi

# Make zsh the default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🐚 Setting zsh as default shell..."
    chsh -s "$(which zsh)"
    echo "✅ zsh set as default shell. Please restart your terminal."
fi

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📥 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install CLI tools
echo "📥 Installing CLI tools..."

if [[ "$OS" == "macos" ]]; then
    TOOLS="fzf zoxide lsd lazygit fd bat atuin git-delta"
    for tool in $TOOLS; do
        if ! brew list "$tool" &>/dev/null; then
            echo "  Installing $tool..."
            brew install "$tool"
        else
            echo "  ✓ $tool"
        fi
    done
else
    # Ubuntu/Debian
    echo "  Installing apt packages..."
    sudo apt install -y fzf fd-find bat curl unzip

    # zoxide
    if ! command -v zoxide &>/dev/null; then
        echo "  Installing zoxide..."
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    else
        echo "  ✓ zoxide"
    fi

    # lsd
    if ! command -v lsd &>/dev/null; then
        echo "  Installing lsd..."
        LSD_VERSION=$(curl -s https://api.github.com/repos/lsd-rs/lsd/releases/latest | grep tag_name | cut -d '"' -f 4)
        curl -sLO "https://github.com/lsd-rs/lsd/releases/download/${LSD_VERSION}/lsd_${LSD_VERSION#v}_amd64.deb"
        sudo dpkg -i lsd_*.deb && rm lsd_*.deb
    else
        echo "  ✓ lsd"
    fi

    # lazygit
    if ! command -v lazygit &>/dev/null; then
        echo "  Installing lazygit..."
        LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep tag_name | cut -d '"' -f 4 | tr -d 'v')
        curl -sLO "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit_*.tar.gz lazygit && sudo mv lazygit /usr/local/bin/ && rm lazygit_*.tar.gz
    else
        echo "  ✓ lazygit"
    fi

    # delta
    if ! command -v delta &>/dev/null; then
        echo "  Installing delta..."
        DELTA_VERSION=$(curl -s https://api.github.com/repos/dandavison/delta/releases/latest | grep tag_name | cut -d '"' -f 4)
        curl -sLO "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb"
        sudo dpkg -i git-delta_*.deb && rm git-delta_*.deb
    else
        echo "  ✓ delta"
    fi

    # atuin
    if ! command -v atuin &>/dev/null; then
        echo "  Installing atuin..."
        curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    else
        echo "  ✓ atuin"
    fi
fi

# Create symlinks using dotlink.sh
echo ""
"$DOTFILES_DIR/dotlink.sh"

# Set global gitignore
git config --global core.excludesfile ~/.gitignore_global

echo ""
echo "✅ Dotfiles initialization completed!"
echo "🔄 Please restart your shell or run 'source ~/.zshrc' to apply changes"
