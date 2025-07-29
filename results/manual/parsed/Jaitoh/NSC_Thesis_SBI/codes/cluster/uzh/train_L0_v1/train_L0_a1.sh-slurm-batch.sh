#!/bin/bash
#FLUX: --job-name=dataset_gen
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --urgency=16

module load anaconda3
source activate sbi
module load gpu
module load cuda
python3 -u ./src/train/train_L0.py \
--run_simulator \
--config_simulator_path './src/config/simulator_Ca_Pb_Ma.yaml' \
--config_dataset_path './src/config/dataset_Sa0_suba1_Ra0.yaml' \
--config_train_path './src/config/train_Ta1.yaml' \
--log_dir './src/train/logs/log-Ca-Pb-Ma-Sa0-suba1-Ra0-Ta1' \
> ./cluster/train_L0/train_L0_a2.log
echo 'finished simulation'
