#!/bin/bash
#FLUX: --job-name=prob205
#FLUX: -c=48
#FLUX: --queue=batch
#FLUX: -t=223200
#FLUX: --priority=16

module load rust 
cargo run --release
