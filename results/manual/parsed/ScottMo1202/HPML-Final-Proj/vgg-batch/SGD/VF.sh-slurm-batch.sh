#!/bin/bash
#FLUX: --job-name=VF
#FLUX: -c=24
#FLUX: --queue=rtx8000
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load anaconda3/2020.07
eval "$(conda shell.bash hook)"
conda activate key
module load python/intel/3.8.6
module load anaconda3/2020.07
cd /scratch/xm2100/final-proj/all-sh/VGG-SGD
python3 ../../run-googlenet.py --cuda --aug=VerticalFlip --model=vgg --numGPUs=2 --batchSize=32 --optimizer=sgd
