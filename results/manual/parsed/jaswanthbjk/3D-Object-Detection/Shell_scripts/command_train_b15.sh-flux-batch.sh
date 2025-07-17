#!/bin/bash
#FLUX: --job-name=br5_FPointNet
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

module load cuda
source ~/anaconda3/bin/activate ~/anaconda3/envs/3DOD_Env
cd /home/jbandl2s/sub_ensembles/models
DATA_FILE="/scratch/jbandl2s/Lyft_dataset/artifacts/frustums_train"
MODEL_LOG_DIR="./log_v1_test/"
RESTORE_MODEL_PATH="./log_v1_test/model.ckpt"
python train_branch_15.py
