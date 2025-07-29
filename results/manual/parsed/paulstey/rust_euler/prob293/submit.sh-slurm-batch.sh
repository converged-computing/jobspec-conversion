#!/bin/bash
#SBATCH --job-name=prob293
#SBATCH --output=prob293-%j.out
#SBATCH --error=prob293-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=24G
#SBATCH --time=01:00:00
#SBATCH --partition=batch
#SBATCH --constraint=48core

module load rust 
cargo run --release
