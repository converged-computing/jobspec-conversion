#!/bin/bash
#SBATCH --output=pca_ica_%A_%a.out
#SBATCH --error=pca_ica_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=25000
#SBATCH --time=00:30:00
#SBATCH --partition=shared
#SBATCH --array=1-10

module load matlab/R2018a-fasrc01
matlab -sd "~/" -nosplash -nodesktop -r "ICA_PCA_array($SLURM_ARRAY_TASK_ID)"
