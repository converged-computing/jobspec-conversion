#!/bin/bash
#SBATCH --job-name=org-red-fr-pnet
#SBATCH --output=/home/jbandl2s/train.%j.out
#SBATCH --error=/home/jbandl2s/train.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0
#SBATCH --mem=130G
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=32

module load cuda
source ~/anaconda3/bin/activate ~/anaconda3/envs/3DOD_Env
cd /home/jbandl2s/Bayes_F_pointnet/frustum-pointnets
DATA_FILE="/scratch/jbandl2s/Lyft_dataset/artifacts/frustums_train"
MODEL_LOG_DIR="./log_v1_test/"
RESTORE_MODEL_PATH="./log_v1_test/model.ckpt"
python train/train.py --gpu 0 --model Part_Bayes_F_pointnet --log_dir train/log_v2 --num_point 1024 --max_epoch 201 --batch_size 32 --decay_step 800000 --decay_rate 0.5
