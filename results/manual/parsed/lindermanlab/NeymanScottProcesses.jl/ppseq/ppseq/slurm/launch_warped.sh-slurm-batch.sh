#!/bin/bash
#SBATCH --job-name=warped
#SBATCH --output=/scratch/users/ahwillia/code/neymanscott/ppseq/slurm/logs/warped_slurm-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=01:00:00
#SBATCH --chdir=/scratch/users/ahwillia/code/neymanscott/ppseq

echo "Working Directory = $(pwd)"
module load julia
srun julia launch_warped_slurm.jl
