#!/bin/bash
#SBATCH --output=/home/lkap/smalllogs/regression_%j.out
#SBATCH --mail-user=leakapelevich@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=4-00:00:00
#SBATCH --partition=sched_mit_sloan_batch

module load julia
srun julia engaging.jl
