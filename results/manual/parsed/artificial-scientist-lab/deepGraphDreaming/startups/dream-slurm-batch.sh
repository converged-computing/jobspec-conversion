#!/bin/bash
#SBATCH --job-name=dream_output
#SBATCH --account=def-ekarimi
#SBATCH --output=./dreamjobsout/out.%j
#SBATCH --error=./dreamjobserr/err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32GB
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=./
#SBATCH --array=0-999

module load python/3.9
module load scipy-stack
source env/bin/activate
srun python dream.py $SLURM_ARRAY_TASK_ID
