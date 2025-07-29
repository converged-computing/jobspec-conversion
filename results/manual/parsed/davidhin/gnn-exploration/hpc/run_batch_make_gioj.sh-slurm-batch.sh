#!/bin/bash
#SBATCH --job-name=make_gioj
#SBATCH --output=hpc/logs/batch_gi_%a.out
#SBATCH --error=hpc/logs/batch_gi_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8GB
#SBATCH --time=00:20:00
#SBATCH --array=1-3

module load Singularity
module load CUDA/10.2.89
singularity run main.simg -p gnnproject/analysis/run_batch_make_gioj.py -a $SLURM_ARRAY_TASK_ID
