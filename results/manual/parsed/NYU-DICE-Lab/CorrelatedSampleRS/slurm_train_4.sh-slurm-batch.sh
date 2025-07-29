#!/bin/bash
#SBATCH --job-name=train_imagenet
#SBATCH --output=out_%A_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:rtx8000:4
#SBATCH --mem=32GB
#SBATCH --time=1-23:59:00

module load python/intel/3.8.6
module load cuda/10.2.89
source /scratch/aaj458/venv/bin/activate;
python train_smooth.py imagenet -mt resnet50 -dpath /scratch/work/public/imagenet/ -dvalpath /scratch/aaj458/data/ImageNet/val/  -o saved_models/imagenet/pgd1step_patch_30 --pretrained --batch 128 --lr 0.1 --workers 16 --noise_sd 1.00 --adv-training --attack PGD  --num-steps 1 --epsilon 255 -ps 224 -pstr 30 -patch --train-multi-noise --epochs 1 --parallel --num-noise-vec 1 --no-grad-attack
