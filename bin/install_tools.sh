#!/bin/bash

brew install terminal-notifier direnv go-task gnu-sed jq k9s wifi-password kubectl fzf lazygit jq helm buf

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -fsSL https://tailscale.com/install.sh | sh

cargo install bat eza ripgrep du-dust zellij mprocs irust bacon cargo-info ncspot porsmo speedtest-rs rtx-cli starship wiki-tui atuin
cargo install --locked --bin jj jj-cli
cargo install youtube-tui --locked
cargo install flamelens --locked

uv tool install --python 3.13 bagels
pipx install smassh
yay -S spotify-player
go install github.com/dhth/act3@latest
go install github.com/erroneousboat/slack-term@latest
go install github.com/dhth/kplay@latest
pacman -S e1s
brew install idoavrah/homebrew/tftui   Not Committed Yet
