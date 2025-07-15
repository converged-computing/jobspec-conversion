#!/bin/bash
#FLUX: --job-name=prob293
#FLUX: -c=48
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --priority=16

module load rust 
cargo run --release
