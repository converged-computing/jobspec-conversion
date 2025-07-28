#!/bin/bash
#FLUX: --job-name=pseudo_lidar_pipeline
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --urgency=16

module load GCC/11.3.0
module load CUDA/11.7.0
module load OpenMPI/4.1.4
module load TensorFlow/2.11.0-CUDA-11.7.0
module load PyTorch/1.12.0-CUDA-11.7.0
module load OpenCV/4.6.0-contrib
module load scikit-learn/1.1.2
pip3 install torchvision==0.2.0
pip3 list | grep torchvision
cd models/PSMNet/scripts/
echo Began predict
sh predict.sh
echo Finished predict
