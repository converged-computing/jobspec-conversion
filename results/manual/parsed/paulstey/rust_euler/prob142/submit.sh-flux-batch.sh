#!/bin/bash
#FLUX: --job-name=prob142
#FLUX: -c=4
#FLUX: --queue=batch
#FLUX: -t=28800
#FLUX: --priority=16

module load rust 
cargo run --release
