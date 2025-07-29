#!/bin/bash
#SBATCH --job-name=gpu_mono
#SBATCH --output=gpu_mono%A_%a.out
#SBATCH --error=gpu_mono%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=2-12:00:00
#SBATCH --qos=qos_gpu-t4
#SBATCH --array=0

set -x
cd ${SLURM_SUBMIT_DIR}
module purge
module load python/2.7.16
module load tensorflow-gpu/py3/2.0.0-beta1
module load pandas
srun python Main_X.py
