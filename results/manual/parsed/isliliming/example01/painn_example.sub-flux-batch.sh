#!/bin/bash
#FLUX: --job-name=buttery-peanut-4016
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load GCC  OpenMPI torchvision/0.13.1-CUDA-11.7.0
source ~/painn01/bin/activate
srun python ./train-painn-example.py --cutoff 5.0 --features 32 --max_epochs 100 --layer 2 --split $split > output_training.out 2>&1
