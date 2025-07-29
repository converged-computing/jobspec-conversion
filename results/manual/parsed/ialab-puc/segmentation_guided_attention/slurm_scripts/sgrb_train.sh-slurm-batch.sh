#!/bin/bash
#SBATCH --job-name=sgrb-rcnn
#SBATCH --output=output/sgrb_beautiful_%j.log
#SBATCH --error=output/err/sgrb_beautiful_%j.err
#SBATCH --mail-user=afcadiz@uc.cl
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:Geforce-GTX:1
#SBATCH --mem=10000mb
#SBATCH --time=7-00:00:00
#SBATCH --nodelist=hydra
#SBATCH --dependency=500

pyenv/bin/python3 train.py  --model sgrb \
--max_epochs 40 \
--premodel resnet \
--attribute beautiful \
--wd 0 \
--lr 0.001  \
--batch_size 32 \
--dataset ../datasets/placepulse  \
--model_dir ../storage/models_seg  \
--tag sgrb \
--csv votes/ \
--attention_normalize local \
--n_layers 1 --n_heads 1 --n_outputs 1 \
--eq --cuda \
--cm \
--softmax \
--lr_decay 
