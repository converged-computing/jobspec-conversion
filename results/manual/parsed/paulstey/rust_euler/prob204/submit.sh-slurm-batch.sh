#!/bin/bash
#SBATCH --job-name=prob205
#SBATCH --output=prob204-%j.out
#SBATCH --error=prob204-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=24G
#SBATCH --time=01:00:00
#SBATCH --constraint=48core

module load rust 
cargo run --release
