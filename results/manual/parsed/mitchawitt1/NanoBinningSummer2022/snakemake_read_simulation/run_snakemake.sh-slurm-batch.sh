#!/bin/bash
#SBATCH --job-name=sm_read_simulation
#SBATCH --output=new_10S10C1_readsim.out
#SBATCH --error=new_10S10C1_readsim.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=15G
#SBATCH --time=16:00:00
#SBATCH --partition=panda

source ~/.bashrc
snakemake --cores 1
