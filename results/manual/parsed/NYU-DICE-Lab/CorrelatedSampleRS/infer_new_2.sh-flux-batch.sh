#!/bin/bash
#FLUX: --job-name=certify_infer_minmax
#FLUX: -t=86340
#FLUX: --priority=16

PATCH_SIZE=$1
PATCH_STRIDE=$2
SIGMA=$3
RMODE=$4
module purge
singularity exec --nv \
	--overlay /scratch/aaj458/singularity_containers/my_pytorch.ext3:ro \
	/scratch/aaj458/singularity_containers/cuda11.1.1-cudnn8-devel-ubuntu20.04.sif \
	/bin/bash -c "source /ext3/env.sh; python infer_certify_pretrained_salman_uncorrelated.py cifar10 -dpath /scratch/aaj458/data/Cifar10/ -mp salman_models/pretrained_models/cifar10/finetune_cifar_from_imagenetPGD2steps/PGD_10steps_30epochs_multinoise/2-multitrain/eps_64/cifar10/resnet110/noise_$SIGMA/checkpoint.pth.tar -mt resnet110 -ni 100 -ps $PATCH_SIZE -pstr $PATCH_STRIDE -sigma $SIGMA --N0 100 --N 10000 --patch -o cifar10_SOTA/patchmax/ --batch 400 -rm $RMODE -ns 36"
