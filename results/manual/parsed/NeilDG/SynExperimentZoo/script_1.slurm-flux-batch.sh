#!/bin/bash
#FLUX: --job-name=blue-buttface-2130
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: --urgency=16

NETWORK_VERSION=$1
ITERATION=$2
echo "CUDA_DEVICE=/dev/nvidia/$CUDA_VISIBLE_DEVICES"
nvidia-smi
module load anaconda/3-2021.11
module load cuda/10.1_cudnn-7.6.5
source activate NeilGAN_V2
srun python train_img2img_main.py \
--server_config=0 --img_to_load=-1 \
--plot_enabled=0 --save_per_iter=500 --network_version=$NETWORK_VERSION --iteration=$ITERATION
conda deactivate
