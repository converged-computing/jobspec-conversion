#!/bin/bash
#SBATCH --job-name=Path
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=200M
#SBATCH --time=12:00:00

export RUST_LOG='info'

SCENE=./images/refracting-spheres/20000
export RUST_LOG=info
srun ./spectral $SCENE
