#!/bin/bash
#FLUX: --job-name=hairy-staircase-5055
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export MODULEPATH='/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/'

sleep 5s
export OMP_NUM_THREADS=1
export MODULEPATH=/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/
source activate imagenet
python main.py --arch resnet20 --batch-size 128 --epochs 200 --lr 0.1 --lr-drop 80 120 160 \
--exp-name resnet20/baseline
