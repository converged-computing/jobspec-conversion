#!/bin/bash
#SBATCH --job-name=minimal_VQE_cirq
#SBATCH --account=rrg-rgmelko-ab
#SBATCH --output=minimal_VQE_cirq.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=03:00:00
#SBATCH --array=1-160

module load nixpkgs/16.09 gcc/7.3.0 julia
julia --project -O3 --check-bounds=no run_graham.jl $SLURM_ARRAY_TASK_ID
