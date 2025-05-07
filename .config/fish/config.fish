alias vim="nvim"
alias kgp='kubectl get pods'
set -q KREW_ROOT; and set -gx PATH $PATH $KREW_ROOT/.krew/bin; or set -gx PATH $PATH $HOME/.krew/bin

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

alias cl="clear"
alias c="clear"
alias pg='ps -ef | grep'
alias pkill!="pkill -9 -f "
alias lj='jobs'

alias timefish="time fish -i -c echo"


alias ls='eza -lH --icons --git'
alias tree='eza --tree'


alias l='eza -lH --icons --git'
alias e='eza -lH --icons --git'
alias la='eza -laH --icons --git'
alias lla='eza -laH --icons --git'
alias lt='eza --tree'

alias zed="zellij attach --create dotfiles options --default-cwd ~/.dotfiles/"

alias terraform="tofu"

set -gx fish_greeting
set -gx DOTFILES $HOME/.dotfiles
set -gx EDITOR nvim
set -gx K9S_CONFIG_DIR "/Users/hcasten/.config/k9s/"
set -gx ATAC_KEY_BINDINGS $HOME/.config/atac.toml

set -gx OPEN_WEBUI_API_KEY (atuin kv get open_webui)
set -gx GROQ_API_KEY (atuin kv get groq)
set -gx OPENROUTER_API_KEY (atuin kv get openrouter)

fish_add_path /usr/local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path $DOTFILES/bin
fish_add_path /usr/local/opt/libpq/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/openjdk@17/bin
fish_add_path /Users/hcasten/.deno/bin

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
    # Enable directory-specific variables
    direnv hook fish | source
    zoxide init fish | source

    # # Better command history with fzf
    # if type -q fzf
    #     set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --inline-info"
    #     fzf_key_bindings
    # end
end
alias claude="/Users/hcasten/.claude/local/claude"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/hcasten/.cache/lm-studio/bin
# End of LM Studio CLI section

