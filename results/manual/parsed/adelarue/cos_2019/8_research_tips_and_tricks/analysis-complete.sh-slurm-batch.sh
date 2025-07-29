#!/bin/bash
#SBATCH --output=logs/experiment_%a.log
#SBATCH --mail-user=adelarue@mit.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:15:00
#SBATCH --array=1-200

module load sloan/julia/1.0.0
module load sloan/python/modules/2.7
srun julia analysis-complete.jl $SLURM_ARRAY_TASK_ID
