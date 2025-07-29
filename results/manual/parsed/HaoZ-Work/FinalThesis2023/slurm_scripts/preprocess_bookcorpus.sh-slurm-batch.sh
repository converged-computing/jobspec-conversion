#!/bin/bash
#SBATCH --job-name=bookcorpus-preprocess
#SBATCH --output=/ukp-storage-1/zhang/slurm_logs/bookcorpus-preprocess-%j.out
#SBATCH --mail-user=hao.zhang@stud.tu-darmstadt.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --gres=gpu:1
#SBATCH --mem=256GB
#SBATCH --qos=yolo
#SBATCH --constraint=gpu_model:a180

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
