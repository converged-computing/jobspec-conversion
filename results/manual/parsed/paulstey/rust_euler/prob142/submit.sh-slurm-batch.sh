#!/bin/bash
#SBATCH --job-name=prob142
#SBATCH --output=prob142-%j.out
#SBATCH --error=prob142-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=24G
#SBATCH --time=08:00:00
#SBATCH --constraint=cascade

module load rust 
cargo run --release
