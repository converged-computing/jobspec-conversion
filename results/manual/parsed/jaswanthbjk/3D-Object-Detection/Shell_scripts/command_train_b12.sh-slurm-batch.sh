#!/bin/bash
#SBATCH --job-name=br3_FPointNet
#SBATCH --output=/home/jbandl2s/train.%j.out
#SBATCH --error=/home/jbandl2s/train.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0
#SBATCH --mem=16G
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=32

module load cuda
source ~/anaconda3/bin/activate ~/anaconda3/envs/3DOD_Env
cd /home/jbandl2s/sub_ensembles/models
DATA_FILE="/scratch/jbandl2s/Lyft_dataset/artifacts/frustums_train"
MODEL_LOG_DIR="./log_v1_test/"
RESTORE_MODEL_PATH="./log_v1_test/model.ckpt"
python train_branch_12.py
