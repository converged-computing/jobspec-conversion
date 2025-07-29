#!/bin/bash
#SBATCH --job-name=BayesOpt
#SBATCH --account=gpu_gres
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu
#SBATCH --array=0-5

python optimize.py -d $1 -i ${SLURM_ARRAY_TASK_ID} -e EB
