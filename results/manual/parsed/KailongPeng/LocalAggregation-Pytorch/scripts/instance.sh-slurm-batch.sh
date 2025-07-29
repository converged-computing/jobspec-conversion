#!/bin/bash
#SBATCH --job-name=LA
#SBATCH --output=logs/%J.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=100g
#SBATCH --time=06:00:00
#SBATCH --partition=psych_gpu

set -e
nvidia-smi
cd /gpfs/milgram/project/turk-browne/projects/LocalAggregation-Pytorch/
. /gpfs/milgram/apps/hpc.rhel7/software/Python/Anaconda3/etc/profile.d/conda.sh
conda activate py36
python --version
python -u /gpfs/milgram/pi/turk-browne/projects/sandbox/sandbox/docker/hello.py
cd /gpfs/milgram/project/turk-browne/projects/LocalAggregation-Pytorch
CUDA_VISIBLE_DEVICES=0 python -u ./scripts/instance.py  "${1}"
nvidia-smi
echo "done"
