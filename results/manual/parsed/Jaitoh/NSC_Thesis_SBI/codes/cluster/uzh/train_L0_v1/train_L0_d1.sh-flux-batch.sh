#!/bin/bash
#FLUX: --job-name=train_L0_d1
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --urgency=16

module load anaconda3
source activate sbi
module load t4
module load cuda
python3 -u ./src/train/train_L0.py \
--config_simulator_path './src/config/simulator_Ca_Pb_Ma.yaml' \
--config_dataset_path './src/config/dataset_Sb0_suba1_Rc0.yaml' \
--config_train_path './src/config/train_Ta1.yaml' \
--log_dir './src/train/logs/log-train_L0-d1' \
--gpu \
-y > ./cluster/uzh/train_L0_v1/train_logs/train_L0_d1.log
echo 'finished simulation'
