#!/bin/bash
#FLUX: --job-name=chocolate-despacito-4413
#FLUX: --queue=spider
#FLUX: -t=21600
#FLUX: --urgency=16

export LR='0.0005 # CNN'

source ~/.bashrc
conda activate ncar
module load gcc openmpi/gcc cudatoolkit
export LR=0.0005 # CNN
srun --cpus-per-task 6 --ntasks-per-node 8 -N 1 -u python pytorch_eke.py --lr $LR \
     --log-interval 1000 --model 'resnet' --batch-size 512 --epochs 100 \
     --weighted-sampling
