#!/bin/bash
#SBATCH --account=proj_1329
#SBATCH --output=/home/myurachinskiy/CLIP/summer-clip/scripts/outs/slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

export PYTHONPATH='${PYTHONPATH}:${SUMMER_CLIP_PATH}'
export TRANSFORMERS_OFFLINE='1'
export HF_DATASETS_OFFLINE='1'

nvidia-smi
date
UPL_PATH="/home/myurachinskiy/CLIP/summer-clip/summer_clip/upl/UPL/scripts"
export PYTHONPATH="${PYTHONPATH}:${SUMMER_CLIP_PATH}"
export TRANSFORMERS_OFFLINE=1
export HF_DATASETS_OFFLINE=1
cd $UPL_PATH || exit
bash upl_test_existing_logits.sh ssstanford_cars rn50_ep50 end 16 16 False True
