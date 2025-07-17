#!/bin/bash
#FLUX: --job-name=grace_setup
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module load GCC/11.3.0
module load CUDA/11.7.0
module load OpenMPI/4.1.4
module load TensorFlow/2.11.0-CUDA-11.7.0
module load PyTorch/1.12.0-CUDA-11.7.0
module load OpenCV/4.6.0-contrib
module load scikit-learn/1.1.2
module load torchvision
cd processing/
sh process.sh
