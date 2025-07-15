#!/bin/bash
#FLUX: --job-name=Bayes-fpointnet
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

module load cuda
cd /home/jbandl2s/Reference
DATA_FILE="/scratch/jbandl2s/Lyft_dataset/artifacts/augmented_train_data"
MODEL_LOG_DIR="./log_v1_test/"
RESTORE_MODEL_PATH="./log_v1_test/model.ckpt"
python train_v3.py --gpu 0 --model Bayes_F_pointnet --log_dir "./log_v1_test/" --max_epoch 200 --batch_size 32 --decay_step 800000 --decay_rate 0.5 --data_dir "/scratch/jbandl2s/Lyft_dataset/artifacts/frustums_train" --is_bayesian True
