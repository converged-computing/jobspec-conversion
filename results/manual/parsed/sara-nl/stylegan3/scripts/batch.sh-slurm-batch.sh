#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=72
#SBATCH --time=08:00:00
#SBATCH --exclusive

cd ~/NKI/stylegan3/
source load_env.sh
python train.py --outdir=runs --cfg=stylegan3-r --data=/projects/2/managed_datasets/CHESTXRAY/chestxray.zip --gpus=4 --batch=32 --gamma=32 --batch-gpu=4 --tick=1 --metrics=none --snap 5
