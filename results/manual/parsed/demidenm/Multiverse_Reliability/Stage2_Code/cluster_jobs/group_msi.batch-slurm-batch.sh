#!/bin/bash
#SBATCH --job-name=group_abcd
#SBATCH --account=faird
#SBATCH --output=log_abcd/%x_%A_%a.out
#SBATCH --error=log_abcd/%x_%A_%a.err
#SBATCH --mail-user=mdemiden@umn.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=6G
#SBATCH --time=00:20:00
#SBATCH --partition=agsmall,msismall
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-89

source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate fmri_env
ID=${SLURM_ARRAY_TASK_ID}
bash ./batch_jobs/group${ID}
