#!/bin/bash
#FLUX: --job-name=sd
#FLUX: -c=10
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load python/intel/3.8.6
source ../../env/bin/activate
python3 train_smooth.py cifar10 -mt resnet110 -dpath "/scratch/mp5847/dataset/" --noise_sd 0.25 --outdir "/scratch/mp5847/checkpoints" --workers 6
