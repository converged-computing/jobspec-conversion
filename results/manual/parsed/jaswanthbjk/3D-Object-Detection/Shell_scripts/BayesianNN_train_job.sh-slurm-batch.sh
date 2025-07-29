#!/bin/bash
#SBATCH --job-name=Bayes-fpointnet
#SBATCH --output=/home/jbandl2s/train.%j.out
#SBATCH --error=/home/jbandl2s/train.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0
#SBATCH --mem=64G
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=32

module load cuda
cd /home/jbandl2s/Reference
DATA_FILE="/scratch/jbandl2s/Lyft_dataset/artifacts/augmented_train_data"
MODEL_LOG_DIR="./log_v1_test/"
RESTORE_MODEL_PATH="./log_v1_test/model.ckpt"
python train_v3.py --gpu 0 --model Bayes_F_pointnet --log_dir "./log_v1_test/" --max_epoch 200 --batch_size 32 --decay_step 800000 --decay_rate 0.5 --data_dir "/scratch/jbandl2s/Lyft_dataset/artifacts/frustums_train" --is_bayesian True
