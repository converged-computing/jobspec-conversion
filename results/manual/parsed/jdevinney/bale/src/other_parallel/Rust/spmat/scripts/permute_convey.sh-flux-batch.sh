#!/bin/bash
#FLUX: --job-name=quirky-malarkey-1400
#FLUX: -N=2
#FLUX: -t=60
#FLUX: --priority=16

srun $HOME/Rust/pshmem_private/target/release/examples/permute_convey
