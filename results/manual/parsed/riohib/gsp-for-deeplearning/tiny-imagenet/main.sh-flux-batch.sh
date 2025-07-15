#!/bin/bash
#FLUX: --job-name=crunchy-truffle-2268
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export MODULEPATH='/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/'

sleep 5s
export OMP_NUM_THREADS=1
export MODULEPATH=/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/
source activate imagenet
python main_dali_gsp.py -a resnet18 --batch-size 256 --epochs 200 --exp-name base_tiny_res18 --lr 0.2 \
--lr-drop 100 150 --dataset tiny_imagenet /data/users2/rohib/datasets/tiny-imagenet-200
