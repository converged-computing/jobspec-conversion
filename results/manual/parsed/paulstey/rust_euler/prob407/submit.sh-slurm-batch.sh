#!/bin/bash
#SBATCH --job-name=prob407
#SBATCH --output=prob407-%j.out
#SBATCH --error=prob407-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=80G
#SBATCH --time=12:30:00
#SBATCH --partition=batch
#SBATCH --constraint=48core

module load rust 
cargo run 
