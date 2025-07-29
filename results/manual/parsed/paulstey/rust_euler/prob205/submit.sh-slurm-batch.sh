#!/bin/bash
#SBATCH --job-name=prob205
#SBATCH --output=prob205-%j.out
#SBATCH --error=prob205-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=24G
#SBATCH --time=2-14:00:00
#SBATCH --partition=batch
#SBATCH --constraint=48core

module load rust 
cargo run --release
