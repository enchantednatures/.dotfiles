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

set -gx fish_greeting
set -gx DOTFILES $HOME/.dotfiles
set -gx EDITOR nvim
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
set -gx ATAC_KEY_BINDINGS $HOME/.config/atac.toml

set -gx OPEN_WEBUI_API_KEY (atuin kv get open_webui)
set -gx GROQ_API_KEY (atuin kv get groq)
set -gx OPENROUTER_API_KEY (atuin kv get openrouter)

# Add common paths across platforms
set -x GOPATH $HOME/go
fish_add_path $GOPATH/bin
fish_add_path /usr/local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path $DOTFILES/bin

function oatmeal-sessions
    pushd (oatmeal sessions dir)
    set id (rg --color always -n . | fzf --ansi | string split -f1 ':' | string split -f1 '.' | head -n1)
    oatmeal sessions open --id "$id"
    popd
end

if status is-interactive
    # Tool completions with lazy loading
    for tool in flux helm tkn kubectl
        function $tool --inherit-variable tool
            functions --erase $tool
            eval "$tool completion fish" | source
            command $tool $argv
        end
    end


    # Initialize shell enhancements
    if type -q atuin
        atuin init fish --disable-up-arrow | source
    end
    
    if type -q starship
        starship init fish | source
    end

    # Enable vi mode
    fish_vi_key_bindings

    atuin gen-completions --shell fish | source
    task --completion fish | source
    # Enable directory-specific variables
    direnv hook fish | source
    zoxide init fish | source

    # # Better command history with fzf
    # if type -q fzf
    #     set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --inline-info"
    #     fzf_key_bindings
    # end
end
# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


# opencode
fish_add_path /Users/hcasten/.opencode/bin
alias claude="/home/hcasten/.claude/local/claude"

# opencode
fish_add_path /home/hcasten/.opencode/bin
