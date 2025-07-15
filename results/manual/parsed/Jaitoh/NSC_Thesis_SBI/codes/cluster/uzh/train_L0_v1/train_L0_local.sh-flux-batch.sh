#!/bin/bash
#FLUX: --job-name=dataset_gen
#FLUX: -c=12
#FLUX: -t=86400
#FLUX: --urgency=16

python3 -u ./src/train/train_L0.py \
--run_simulator \
--config_simulator_path './src/config/test_simulator.yaml' \
--config_dataset_path './src/config/test_dataset.yaml' \
--config_train_path './src/config/test_train.yaml' \
--log_dir './src/train/log_test' \
--gpu \
-y
echo 'finished simulation'
