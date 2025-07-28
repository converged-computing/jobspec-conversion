#!/bin/bash
#FLUX: --job-name=project
#FLUX: -c=20
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load anaconda3/2020.07
eval "$(conda shell.bash hook)"
conda activate key
module load python/intel/3.8.6
cd project
python train_time.py --upscale_factor 4 --cuda --epochs 6 --bs 32
python train_time.py --upscale_factor 4 --cuda --epochs 6 --bs 64
python train_time.py --upscale_factor 4 --cuda --epochs 6 --bs 64 --lr 0.0002
