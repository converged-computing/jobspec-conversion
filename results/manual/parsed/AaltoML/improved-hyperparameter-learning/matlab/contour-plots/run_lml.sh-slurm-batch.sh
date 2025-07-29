#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --mem=1G
#SBATCH --time=4-04:00:00
#SBATCH --array=0-440

mkdir -p lml/ionosphere
srun matlab -nojvm -nosplash -batch "MCMC_lml($SLURM_ARRAY_TASK_ID, 'ionosphere', -1, 5)"
