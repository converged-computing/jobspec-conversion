#!/bin/bash
#FLUX: --job-name=org-red-fr-pnet
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

module load cuda
source ~/anaconda3/bin/activate ~/anaconda3/envs/3DOD_Env
cd /home/jbandl2s/Bayes_F_pointnet/frustum-pointnets
DATA_FILE="/scratch/jbandl2s/Lyft_dataset/artifacts/frustums_train"
MODEL_LOG_DIR="./log_v1_test/"
RESTORE_MODEL_PATH="./log_v1_test/model.ckpt"
python train/train.py --gpu 0 --model Part_Bayes_F_pointnet --log_dir train/log_v2 --num_point 1024 --max_epoch 201 --batch_size 32 --decay_step 800000 --decay_rate 0.5
