#!/bin/bash
#SBATCH --job-name=serial_jl
#SBATCH --mail-user=linghuiwu@uchicago.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:05:00
#SBATCH --array=1-10:1

module load julia
julia hello_world.jl $SLURM_ARRAY_TASK_ID
