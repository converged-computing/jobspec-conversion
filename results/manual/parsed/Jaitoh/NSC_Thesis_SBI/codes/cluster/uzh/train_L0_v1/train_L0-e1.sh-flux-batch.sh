#!/bin/bash
#FLUX: --job-name=train_L0-e1
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --urgency=16

module load intel
module load anaconda3
source activate sbi
module load t4
python3 -u ./src/train/train_L0.py \
--seed 0 \
--config_simulator_path './src/config/simulator_Ca_Pb_Ma.yaml' \
--config_dataset_path './src/config/dataset_Sb0_suba1_Ra0.yaml' \
--config_train_path './src/config/train_Ta1_2.yaml' \
--log_dir './src/train/logs/logs_L0_v1/log-train_L0-e1' \
--gpu \
-y > ./cluster/uzh/train_L0_v1/train_logs/train_L0-e1.log
echo 'finished simulation'
