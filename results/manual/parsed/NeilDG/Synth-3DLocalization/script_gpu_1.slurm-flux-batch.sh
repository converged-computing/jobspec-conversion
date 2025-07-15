#!/bin/bash
#FLUX: --job-name=loopy-rabbit-8316
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: --urgency=16

NETWORK_VERSION=$1
ITERATION=$2
echo "CUDA_DEVICE=/dev/nvidia/$CUDA_VISIBLE_DEVICES"
echo "Set network to "$NETWORK_VERSION " Set iteration to "$ITERATION
nvidia-smi
module load anaconda/3-2021.11
module load cuda/10.1_cudnn-7.6.5
source activate NeilGAN_V2
srun python train_main-iid.py \
--network_version=$NETWORK_VERSION --iteration=$ITERATION --server_config=5 --plot_enabled=0 --img_to_load=-1
conda deactivate
