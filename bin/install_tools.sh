#!/bin/bash

brew install terminal-notifier direnv go-task gnu-sed jq k9s wifi-password kubectl fzf lazygit jq helm buf 

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -fsSL https://tailscale.com/install.sh | sh


cargo install bat eza ripgrep du-dust zellij mprocs irust bacon cargo-info ncspot porsmo speedtest-rs rtx-cli starship wiki-tui atuin
cargo install --locked --bin jj jj-cli
