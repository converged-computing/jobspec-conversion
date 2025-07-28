#!/bin/bash
#FLUX: --job-name=metalearning_CIFAR_FS_MetaOptNet_RR
#FLUX: -c=4
#FLUX: --queue=project
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load Anaconda3/2022.05
eval "$(conda shell.bash hook)"
conda activate metalearning
srun whichgpu
srun python train.py --save-path "./experiments/CIFAR_FS_MetaOptNet_RR" --train-shot 5 --head Ridge --network ResNet --dataset CIFAR_FS
