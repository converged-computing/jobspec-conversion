#!/bin/bash
#FLUX: --job-name=faux-bits-9339
#FLUX: -n=24
#FLUX: --queue=normal
#FLUX: -t=21600
#FLUX: --urgency=16

module purge
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
cargo run
