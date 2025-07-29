#!/bin/bash
#SBATCH --job-name=autoencoder
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla-k80:1
#SBATCH --mem-per-cpu=10GB
#SBATCH --time=04:30:00
#SBATCH --chdir=/om/user/nprasad/aesap/subs/arch/
#SBATCH --array=0-999

singularity exec -B /om:/om --nv /om/user/nprasad/singularity/tensorflow-1.8.0-gpu-py3.img \
python /om/user/nprasad/aesap/main.py /om/user/nprasad/aesap/ ${SLURM_ARRAY_TASK_ID} 0
