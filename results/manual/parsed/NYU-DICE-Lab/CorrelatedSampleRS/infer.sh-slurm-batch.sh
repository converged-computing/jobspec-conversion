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
python infer_certify.py -dpath /scratch/aaj458/data/ImageNet/val -mt resnet50 -ni 100 --gpu 0 -ps $PATCH_SIZE -pstr $PATCH_STRIDE -sigma $SIGMA --N0 100 --N 10000 -o certify_results_base_nopatch/ --batch 300
