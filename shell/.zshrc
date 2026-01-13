# Dotfiles zshrc
# https://github.com/TravisCao/dotfiles

# Platform detection
if [[ "$OSTYPE" == "darwin"* ]]; then
    HOMEBREW_PREFIX="/opt/homebrew"
else
    HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
if [ ! -d "$ZSH" ]; then
    echo "⚠️  Oh My Zsh not installed. Run ~/dotfiles/init.sh to set up."
    return
fi

ZSH_THEME="robbyrussell"
if [[ "$OSTYPE" == "darwin"* ]]; then
    plugins=(git fzf zoxide)
else
    plugins=(git)
fi

[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# Environment
export PATH="$HOME/.local/bin:$HOME/.atuin/bin:$PATH"
export NODE_OPTIONS="--max-old-space-size=8192"

# Modern CLI tools
command -v lsd &>/dev/null && alias ls="lsd" && alias ll="lsd -la" && alias lt="lsd --tree"
command -v lazygit &>/dev/null && alias lg="lazygit"
command -v bat &>/dev/null && alias cat="bat --paging=never"

# fzf - fuzzy finder (Linux manual setup)
if [[ "$OSTYPE" != "darwin"* ]] && command -v fzf &>/dev/null; then
    [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
    [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
fi

# zoxide - smart cd (Linux manual setup)
if [[ "$OSTYPE" != "darwin"* ]] && command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

# Atuin - shell history
if command -v atuin &>/dev/null; then
    eval "$(atuin init zsh)"
fi

# Delta - git diff
if command -v delta &>/dev/null; then
    export GIT_PAGER="delta"
fi

# Aliases
alias zshrc="vim ~/dotfiles/shell/.zshrc"
alias zshlocal="vim ~/.zshrc"
alias sz="source ~/dotfiles/shell/.zshrc"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d "$PYENV_ROOT/bin" ]]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    command -v pyenv &>/dev/null && eval "$(pyenv init - zsh)"
fi

# fnm (Node version manager)
if [ -d "$HOMEBREW_PREFIX/opt/fnm/bin" ]; then
    eval "$(fnm env)"
fi

# Load machine-specific local configurations
# In ZDOTDIR architecture, ~/.zshrc is the local config file
[ -f ~/.zshrc ] && source ~/.zshrc

# Dotfiles sync detection
if [ -d ~/dotfiles ]; then
    # Local changes
    [ -n "$(git -C ~/dotfiles status --porcelain 2>/dev/null)" ] && \
        echo "dotfiles: local changes detected"
    # Remote updates (async, no startup delay)
    (~/dotfiles/sync.sh check &) 2>/dev/null
fi

# opencode
[ -d "$HOME/.opencode/bin" ] && export PATH="$HOME/.opencode/bin:$PATH"

# Antigravity (macOS only)
[ -d "$HOME/.antigravity/antigravity/bin" ] && export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
