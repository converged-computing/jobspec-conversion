#!/bin/bash
#SBATCH --job-name=train
#SBATCH --output=logs/output.train.%j
#SBATCH --error=logs/error.train.%j
#SBATCH --mail-user=s6abtyag@uni-bonn.de
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=50GB
#SBATCH --time=20:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=./
#SBATCH --array=13-30
#SBATCH --dependency=1585071

module load anaconda/3/2021.11
source activate /u/atya/conda-envs/tf-gpu4
time srun python single_index_predict_z_with_pvol.py --job_id $SLURM_JOB_ID --model_type attention --trial_index 853 --snr_group 1 --max_seconds 71500 > logs/output.train.$SLURM_JOB_ID
