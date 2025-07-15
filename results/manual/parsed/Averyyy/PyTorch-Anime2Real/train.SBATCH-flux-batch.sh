#!/bin/bash
#FLUX: --job-name=cyclegan_a2r
#FLUX: -c=6
#FLUX: -t=432000
#FLUX: --urgency=16

module purge
module load anaconda3
module load cuda
echo "start training"
cd /gpfsnyu/scratch/hq443/PyTorch-Anime2Real
source activate /scratch/hq443/conda_envs/torch-p2c
python train.py --dataroot datasets/a2r/ --cuda 
echo "end training"
