#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00
#SBATCH --qos=debug
#SBATCH --constraint=haswell

srun $HOME/Rust/pshmem_private/target/release/examples/permute_convey
