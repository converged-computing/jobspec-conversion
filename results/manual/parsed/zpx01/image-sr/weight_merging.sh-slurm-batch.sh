#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:10
#SBATCH --time=3-00:00:00
#SBATCH --qos=low

export PYTHONUNBUFFERED='1'

pwd
hostname
date
nvidia-smi
echo "Starting SwinIR Weight Merging job (classical SR)..."
source ~/.bashrc
conda activate image-sr
export PYTHONUNBUFFERED=1
for ALPHA in 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9
do
        python3 weight_merging.py \
        --alpha ${ALPHA}
done
date
