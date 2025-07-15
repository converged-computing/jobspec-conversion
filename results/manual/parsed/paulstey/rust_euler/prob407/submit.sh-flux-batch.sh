#!/bin/bash
#FLUX: --job-name=prob407
#FLUX: -c=48
#FLUX: --queue=batch
#FLUX: -t=45000
#FLUX: --priority=16

module load rust 
cargo run 
