#!/bin/bash
#SBATCH --output=logs/experiment_%a.log
#SBATCH --mail-user=adelarue@mit.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:15:00
#SBATCH --partition=sched_mit_sloan_batch
#SBATCH --array=1-200

module load julia/1.2.0
module load sloan/python/modules/2.7
srun julia 2-analysis-complete.jl $SLURM_ARRAY_TASK_ID
