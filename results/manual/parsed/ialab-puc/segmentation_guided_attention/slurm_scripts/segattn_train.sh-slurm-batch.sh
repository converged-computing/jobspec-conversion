#!/bin/bash
#SBATCH --job-name=segattn-rcnn
#SBATCH --output=output/segattn_wealthy_%j.log
#SBATCH --error=output/err/segattn_wealthy_%j.err
#SBATCH --mail-user=afcadiz@uc.cl
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1080Ti:1
#SBATCH --mem=10000mb
#SBATCH --time=7-00:00:00
#SBATCH --partition=ialab-high
#SBATCH --dependency=500

export PATH='$PATH:/usr/local/cuda-10.0/bin'
export CUDADIR='/usr/local/cuda-10.0'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/local/cuda-10.0/lib64'

export PATH=$PATH:/usr/local/cuda-10.0/bin
export CUDADIR=/usr/local/cuda-10.0
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.0/lib64
pyenv/bin/python3 train.py  --model segattn \
--max_epochs 30 \
--premodel resnet \
--attribute wealthy \
--wd 0 \
--lr 0.001  \
--batch_size 4 \
--dataset ../datasets/placepulse  \
--model_dir ../storage/models_seg  \
--tag large_images \
--csv votes/ \
--attention_normalize local \
--n_layers 1 --n_heads 1 --n_outputs 1 \
--eq --cuda \
--cm \
--softmax \
--pbar \
--ft 
