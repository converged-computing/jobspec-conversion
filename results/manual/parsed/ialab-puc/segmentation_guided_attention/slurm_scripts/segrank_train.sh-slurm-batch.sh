#!/bin/bash
#SBATCH --job-name=segrank15-rcnn
#SBATCH --output=output/segrank15_safety_%j.log
#SBATCH --error=output/err/segrank15_safety_%j.err
#SBATCH --mail-user=afcadiz@uc.cl
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1080Ti:1
#SBATCH --mem=8000mb
#SBATCH --time=7-00:00:00
#SBATCH --dependency=434

pyenv/bin/python3 train.py  --model segrank \
--max_epochs 40 \
--premodel resnet \
--attribute safety \
--wd 0 \
--lr 0.001  \
--batch_size 32 \
--dataset ../datasets/placepulse  \
--model_dir ../storage/models_seg  \
--tag 15_drop_2d \
--csv votes/ \
--attention_normalize local \
--n_layers 1 --n_heads 1 --n_outputs 1 \
--eq --cuda \
--cm \
--softmax
