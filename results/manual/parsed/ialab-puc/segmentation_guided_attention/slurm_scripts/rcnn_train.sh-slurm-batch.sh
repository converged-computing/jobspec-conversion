#!/bin/bash
#SBATCH --job-name=rcnn-rcnn
#SBATCH --output=output/rcnn_beautiful_normal_%j.log
#SBATCH --error=output/err/rcnn_beautiful_normal%j.err
#SBATCH --mail-user=afcadiz@uc.cl
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1080Ti:1
#SBATCH --mem=10000mb
#SBATCH --time=7-00:00:00
#SBATCH --partition=ialab-high
#SBATCH --nodelist=hydra
#SBATCH --dependency=8591

pyenv/bin/python3 train.py  --model rcnn \
--max_epochs 10 \
--premodel resnet \
--attribute beautiful \
--wd 0.00001 \
--lr 0.001  \
--batch_size 32 \
--dataset ../datasets/placepulse  \
--model_dir ../storage/models_seg  \
--tag rcnn \
--csv votes/ \
--eq --cuda \
--cm \
--sgd \
--ft
