#!/bin/bash
#FLUX: --job-name=bookcorpus-preprocess
#FLUX: -c=128
#FLUX: --queue=yolo
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/mnt/beegfs/work/zhang/conda/env/lib'
export WANDB_CACHE_DIR='/ukp-storage-1/zhang/wandb/cache'
export WANDB_CONFIG_DIR='/ukp-storage-1/zhang/wandb/config'
export CUDA_VISIBLE_DEVICES='0'
export NLTK_DATA='./nltk_data'

source activate /mnt/beegfs/work/zhang/conda/dragon
module purge
module load cuda/11.0 # you can change the cuda version
nvidia-smi
nproc
free -h
cd /ukp-storage-1/zhang/FinalThesis2023/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/beegfs/work/zhang/conda/env/lib
export WANDB_CACHE_DIR=/ukp-storage-1/zhang/wandb/cache
export WANDB_CONFIG_DIR=/ukp-storage-1/zhang/wandb/config
export CUDA_VISIBLE_DEVICES=0
export NLTK_DATA='./nltk_data'
python3 -u preprocess.py -p 128 --run bookcorpus
