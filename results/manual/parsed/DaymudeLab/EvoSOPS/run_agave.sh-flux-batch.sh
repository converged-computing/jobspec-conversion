#!/bin/bash
#FLUX: --job-name=joyous-buttface-9987
#FLUX: --priority=16

module purge
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
cargo run
