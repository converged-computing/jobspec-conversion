#!/bin/bash
#FLUX: --job-name=GPU_job
#FLUX: -c=32
#FLUX: --queue=hgx
#FLUX: -t=176340
#FLUX: --urgency=16

module purge # optional
module load NeSI
module load gcc/9.3.0
module load cuDNN/8.1.1.33-CUDA-11.2.0
nvidia-smi
cd /nesi/project/niwa00018/ML_downscaling_CCAM/training_GAN/
/nesi/project/niwa00004/rampaln/bin/python /nesi/project/niwa00018/ML_downscaling_CCAM/A-Robust-Generative-Adversarial-Network-Approach-for-Climate-Downscaling/train_unet.py $1
