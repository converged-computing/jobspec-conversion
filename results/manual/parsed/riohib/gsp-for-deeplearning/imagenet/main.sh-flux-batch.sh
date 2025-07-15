#!/bin/bash
#FLUX: --job-name=chocolate-parsnip-3187
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export MODULEPATH='/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/'

sleep 5s
export OMP_NUM_THREADS=1
export MODULEPATH=/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/
source activate imagenet
python main_dali_gsp.py -a resnet50 --dist-url 'tcp://127.0.0.1:8801' --dist-backend 'nccl' \
--finetuning --gsp-training --resume-lr --batch-size 1024 --epochs 190 --exp-name gsp_S65_ft85_e20 \
--lr 0.0000004 --finetune-sps 0.85 --multiprocessing-distributed \
--world-size 1 --rank 0 /data/users2/rohib/github/imagenet-data \
--resume ./results/gsp_S65_ft85_e20/checkpoint.pth.tar
