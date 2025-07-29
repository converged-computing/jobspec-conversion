#!/bin/bash
#SBATCH --job-name=first_projinv
#SBATCH --account=${PROFILE}
#SBATCH --output=batch_logs/%x_%A_%a.out
#SBATCH --error=batch_logs/%x_%A_%a.err
#SBATCH --mail-user=${USER}.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=6G
#SBATCH --time=00:20:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-779

source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate fmri_env
module load fsl
ID=${SLURM_ARRAY_TASK_ID}
bash ./batch_run/first${ID}
