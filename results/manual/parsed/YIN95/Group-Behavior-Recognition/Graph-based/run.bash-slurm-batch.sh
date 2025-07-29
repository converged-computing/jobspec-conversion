#!/bin/bash
#SBATCH --output=/Midgard/home/wyin/repo/out_train.log
#SBATCH --error=/Midgard/home/wyin/repo/error_train.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:8
#SBATCH --mem=300GB
#SBATCH --constraint=khazadum|rivendell|belegost|

printenv $SLURM_STEP_GPUS
nvidia-smi
. ~/miniconda3/etc/profile.d/conda.sh
conda activate tr
python main.py recognition -c config/st_gcn.twostream/congreg8-marker/train.yaml
