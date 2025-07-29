#!/bin/bash
#FLUX: --job-name=resne_50
#FLUX: -c=14
#FLUX: --queue=gpu_veryshort
#FLUX: -t=3540
#FLUX: --urgency=16

export PATH='$HOME/.conda/envs/keras_gpu/bin:$PATH'
export PYTHONPATH='/mnt/storage/home/csapo/git_repositories/keras_segmentation:\$PYTHONPATH'

module load CUDA/8.0.44-GCC-5.4.0-2.26
module load libs/cudnn/5.1-cuda-8.0
module load languages/anaconda3/3.7
source activate keras_gpu
export PATH=$HOME/.conda/envs/keras_gpu/bin:$PATH
export PYTHONPATH=/mnt/storage/home/csapo/git_repositories/keras_segmentation:\$PYTHONPATH
srun python train_cnn_fcn_resnet_50.py
