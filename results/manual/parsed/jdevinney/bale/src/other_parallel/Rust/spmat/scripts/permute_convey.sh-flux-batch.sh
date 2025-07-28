#!/bin/bash
#FLUX: --job-name=fat-staircase-6958
#FLUX: -N=2
#FLUX: -t=60
#FLUX: --urgency=16

srun $HOME/Rust/pshmem_private/target/release/examples/permute_convey
