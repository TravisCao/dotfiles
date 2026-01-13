#!/bin/bash

# Dotfiles initialization script
# Usage: ./init.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Initializing dotfiles..."

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    HOMEBREW_PREFIX="/opt/homebrew"
else
    OS="linux"
    HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
    sudo apt update
fi

echo "Detected OS: $OS"

# Install Homebrew (both macOS and Linux)
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for current session
    eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

    # Create .zshrc.local for Linux with Homebrew PATH
    if [[ "$OS" == "linux" ]]; then
        ZSHRC_LOCAL="$HOME/.zshrc.local"
        if [ ! -f "$ZSHRC_LOCAL" ]; then
            echo "Creating $ZSHRC_LOCAL..."
            cat > "$ZSHRC_LOCAL" << 'EOF'
# Machine-specific configurations

# Homebrew (Linux)
[ -d /home/linuxbrew/.linuxbrew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
EOF
        elif ! grep -q "linuxbrew" "$ZSHRC_LOCAL"; then
            echo "Adding Homebrew to $ZSHRC_LOCAL..."
            echo '' >> "$ZSHRC_LOCAL"
            echo '# Homebrew (Linux)' >> "$ZSHRC_LOCAL"
            echo '[ -d /home/linuxbrew/.linuxbrew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$ZSHRC_LOCAL"
        fi
    fi
else
    echo "[ok] Homebrew already installed"
fi

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
    sudo apt install -y fzf fd-find bat curl unzip zoxide

    # git-delta (direct download from GitHub)
    if ! command -v delta &>/dev/null; then
        echo "  Installing git-delta..."
        curl -sLO https://github.com/dandavison/delta/releases/download/0.18.2/git-delta_0.18.2_amd64.deb
        sudo dpkg -i git-delta_0.18.2_amd64.deb
        rm git-delta_0.18.2_amd64.deb
    else
        echo "  [ok] git-delta"
    fi

    # lsd (direct download from GitHub)
    if ! command -v lsd &>/dev/null; then
        echo "  Installing lsd..."
        curl -sLO https://github.com/lsd-rs/lsd/releases/download/v1.2.0/lsd_1.2.0_amd64.deb
        sudo dpkg -i lsd_1.2.0_amd64.deb
        rm lsd_1.2.0_amd64.deb
    else
        echo "  [ok] lsd"
    fi

    # lazygit (direct download)
    if ! command -v lazygit &>/dev/null; then
        echo "  Installing lazygit..."
        curl -sLO https://github.com/jesseduffield/lazygit/releases/download/v0.58.0/lazygit_0.58.0_Linux_x86_64.tar.gz
        tar xf lazygit_*.tar.gz lazygit
        sudo mv lazygit /usr/local/bin/
        rm lazygit_*.tar.gz
    else
        echo "  [ok] lazygit"
    fi

    # atuin
    if ! command -v atuin &>/dev/null; then
        echo "  Installing atuin..."
        curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    else
        echo "  [ok] atuin"
    fi

    # claude code (use brew)
    if ! command -v claude &>/dev/null; then
        echo "  Installing claude code via brew..."
        brew install --cask claude-code
    else
        echo "  [ok] claude"
    fi

    # opencode
    if ! command -v opencode &>/dev/null; then
        echo "  Installing opencode..."
        curl -fsSL https://opencode.ai/install | bash
    else
        echo "  [ok] opencode"
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
