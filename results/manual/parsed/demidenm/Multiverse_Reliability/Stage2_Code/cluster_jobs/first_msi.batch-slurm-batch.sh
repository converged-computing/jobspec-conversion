#!/bin/bash
#SBATCH --job-name=first_abcd
#SBATCH --account=faird
#SBATCH --output=log_abcd/%x_%A_%a.out
#SBATCH --error=log_abcd/%x_%A_%a.err
#SBATCH --mail-user=mdemiden@umn.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=6G
#SBATCH --time=04:00:00
#SBATCH --partition=msismall,agsmall
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-137

source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate fmri_env
module load fsl
ID=${SLURM_ARRAY_TASK_ID}
bash ./batch_jobs/first${ID}
