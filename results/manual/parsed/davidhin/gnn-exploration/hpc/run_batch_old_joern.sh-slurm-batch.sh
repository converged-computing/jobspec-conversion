#!/bin/bash
#SBATCH --job-name=batch_joern
#SBATCH --output=hpc/logs/batch_joern_%a.out
#SBATCH --error=hpc/logs/batch_joern_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=00:10:00
#SBATCH --partition=batch
#SBATCH --array=1-200

module load Singularity
module load CUDA/10.2.89
singularity run main.simg -p gnnproject/analysis/run_batch_old_joern.py -a $SLURM_ARRAY_TASK_ID
