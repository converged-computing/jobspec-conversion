#!/bin/bash
#SBATCH --job-name=lstm-tune
#SBATCH --account=nlpgroup
#SBATCH --mail-user=nrmyas001@cs.uct.ac.za
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100-2g-10gb:1
#SBATCH --time=3-00:00:00

export CUDA_VISIBLE_DEVICES='$(ncvd)'
export WANDB_DIR='/scratch/nrmyas001/'

module load software/TensorFlow-A100-GPU
export CUDA_VISIBLE_DEVICES=$(ncvd)
export WANDB_DIR=/scratch/nrmyas001/
cd /home/nrmyas001/clinical-longformer
python3 /home/nrmyas001/.local/bin/wandb agent yass/clinical-longformer/9kkopb6e \
    2>&1 | tee /scratch/nrmyas001/logs/lstm-tune/$(hostname)$(openssl rand -hex 4).out
