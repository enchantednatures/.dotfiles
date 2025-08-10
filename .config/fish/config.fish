alias vim="nvim"
alias kgp='kubectl get pods'
set -q KREW_ROOT; and set -gx PATH $PATH $KREW_ROOT/.krew/bin; or set -gx PATH $PATH $HOME/.krew/bin
alias cl="clear"
alias c="clear"
alias pg='ps -ef | grep'
alias pkill!="pkill -9 -f "
alias lj='jobs'
alias timefish="time fish -i -c echo"
# File listing aliases using eza
alias ls='eza -lH --icons --git'
alias l='eza -lH --icons --git'
alias la='eza -laH --icons --git'
alias lt='eza --tree'
alias zed="zellij attach --create dotfiles options --default-cwd ~/.dotfiles/"
alias terraform="tofu"

# Set platform-specific configurations
switch (uname)
    case Darwin
        fish_add_path /opt/homebrew/bin
        fish_add_path /opt/homebrew/opt/openjdk@17/bin
        fish_add_path /Users/hcasten/.deno/bin
        # macOS specific pbcopy for pubkey
        alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
        # macOS specific LM Studio path
        set -gx PATH $PATH /Users/hcasten/.cache/lm-studio/bin
end
set -gx K9S_CONFIG_DIR "$HOME/.config/k9s/"


set -gx fish_greeting
set -gx DOTFILES $HOME/.dotfiles
set -gx EDITOR nvim
set -x GOPATH $HOME/go
set -x BUN_INSTALL "$HOME/.bun"

# Combine PATH additions into one call
set -gx PATH \
    $PATH \
    $GOPATH/bin \
    /usr/local/bin \
    $HOME/.cargo/bin \
    $HOME/.local/bin \
    $DOTFILES/bin \
    $BUN_INSTALL/bin \
    $HOME/.opencode/bin

function load_api_keys
    set -gx OPEN_WEBUI_API_KEY (atuin kv get open_webui)
    set -gx GROQ_API_KEY (atuin kv get groq)
    set -gx OPENROUTER_API_KEY (atuin kv get openrouter)
end

if status is-interactive
    # Initialize shell enhancements
    atuin init fish --disable-up-arrow | source
    starship init fish | source

    # Enable vi mode
    fish_vi_key_bindings

    # Enable directory-specific variables
    direnv hook fish | source
    zoxide init fish | source
end
