#!/bin/bash
#SBATCH --output=slurm-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=30G
#SBATCH --time=5-00:00:00
#SBATCH --array=1-200

module load matlab
srun matlab_multithread -nodisplay -nosplash -r "WCnet_mixeddelays_noisy_posteriorpredictivechecks($SLURM_ARRAY_TASK_ID) ; exit(0)"
