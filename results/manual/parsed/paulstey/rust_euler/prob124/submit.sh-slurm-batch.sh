#!/bin/bash
#SBATCH --job-name=prob124
#SBATCH --output=prob124-%j.out
#SBATCH --error=prob124-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=80G
#SBATCH --time=00:10:00
#SBATCH --constraint=48core

module load rust 
cargo run --release 
