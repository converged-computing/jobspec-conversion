#!/bin/bash
#FLUX: --job-name=nerdy-hobbit-2821
#FLUX: --urgency=16

module purge
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
cargo run
