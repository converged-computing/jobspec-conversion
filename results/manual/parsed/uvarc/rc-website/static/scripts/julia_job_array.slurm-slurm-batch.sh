#!/bin/bash
#SBATCH --job-name=runMultiple
#SBATCH --account=hpc_build
#SBATCH --output=runMultiple_%A_%a.out
#SBATCH --error=runMultiple_%A_%a.err
#SBATCH --mail-user=teh1m@virginia.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-5

module purge
module load julia/1.5.0
export SLURM_ARRAY_TASK_ID
julia jobArray.jl
