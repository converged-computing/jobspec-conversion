#!/bin/bash
#FLUX: --job-name=prob111
#FLUX: -c=48
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

module load rust 
cargo run --release
