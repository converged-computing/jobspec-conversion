#!/bin/bash
#FLUX: --job-name=jupyter
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

module purge
module load Python/3.10.8-GCCcore-12.2.0
module load PyTorch/1.12.1-foss-2022a-CUDA-11.7.
module load CUDA/11.7.0
module load cuDNN
module load TensorFlow/2.11.0-foss-2022a-CUDA-11.7.0
source ~/virtual_env/HC/bin/activate
jupyter notebook --no-browser --ip=$( hostname )
