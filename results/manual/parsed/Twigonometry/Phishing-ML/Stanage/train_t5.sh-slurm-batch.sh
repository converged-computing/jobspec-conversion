#!/bin/bash
#SBATCH --job-name=train_t5
#SBATCH --output=train_t5.log
#SBATCH --mail-user=$EMAIL
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:2
#SBATCH --mem=96G
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu-h100
#SBATCH --qos=gpu

export WANDB_PROJECT='train_t5'
export TRANSFORMERS_CACHE='/mnt/parscratch/users/$USERNAME/cache'

module load Anaconda3/2022.10
module load cuDNN/8.8.0.121-CUDA-12.0.0
nvcc --version
nvidia-smi
source /opt/apps/testapps/common/software/staging/Anaconda3/2022.10/bin/activate
conda activate pytorch
export WANDB_PROJECT=train_t5
export TRANSFORMERS_CACHE=/mnt/parscratch/users/$USERNAME/cache
python train_t5.py --data_path=/mnt/parscratch/users/hardcoded/gen_dataset_dict_no_tokens --save_path=/mnt/parscratch/users/hardcoded/no_tokens_
