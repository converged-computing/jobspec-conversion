#!/bin/bash
#FLUX: --job-name=train_imagenet
#FLUX: -c=16
#FLUX: -t=172740
#FLUX: --priority=16

module load python/intel/3.8.6
module load cuda/10.2.89
source /scratch/aaj458/venv/bin/activate;
python train_smooth.py imagenet -mt resnet50 -dpath /scratch/work/public/imagenet/ -dvalpath /scratch/aaj458/data/ImageNet/val/  -o saved_models/imagenet/pgd1step_patch_30 --pretrained --batch 128 --lr 0.1 --workers 16 --noise_sd 1.00 --adv-training --attack PGD  --num-steps 1 --epsilon 255 -ps 224 -pstr 30 -patch --train-multi-noise --epochs 1 --parallel --num-noise-vec 1 --no-grad-attack
