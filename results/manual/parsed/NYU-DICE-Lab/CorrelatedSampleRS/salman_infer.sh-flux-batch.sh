#!/bin/bash
#FLUX: --job-name=infer_ensemble_rs
#FLUX: -c=4
#FLUX: -t=86340
#FLUX: --urgency=16

module load python/intel/3.8.6
module load cuda/10.2.89
PATCH_SIZE=$1
PATCH_STRIDE=$2
SIGMA=$3
source /scratch/aaj458/venv/bin/activate;
python smoothadv/certify.py  imagenet salman_models/pretrained_models/imagenet/PGD_1step/imagenet/eps_1024/resnet50/noise_0.50/checkpoint.pth.tar $SIGMA orig_salman_results/certify_results_salman_model_$SIGMA --max 100 --N0 100 --N 10000 --batch 300
