#!/bin/bash
#SBATCH --mail-user=axxx@gmail.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=8GB
#SBATCH --time=1-00:00:00

nvidia-smi -l > nv-smi_sa.log.${SLURM_JOB_ID} 2>&1 &
python ./main.py
