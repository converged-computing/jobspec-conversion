#!/bin/bash
#FLUX: --job-name=prob124
#FLUX: -c=48
#FLUX: --queue=batch
#FLUX: -t=600
#FLUX: --priority=16

module load rust 
cargo run --release 
