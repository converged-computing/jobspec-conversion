#!/bin/bash
#SBATCH --job-name=prob111
#SBATCH --output=prob111-%j.out
#SBATCH --error=prob111-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=124G
#SBATCH --time=01:00:00
#SBATCH --constraint=48core

module load rust 
cargo run --release
