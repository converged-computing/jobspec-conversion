#!/bin/bash
#SBATCH --job-name=dataset_gen
#SBATCH --output=./cluster/train_L0.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:V100:1
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=GPUMEM32GB

python3 -u ./src/train/train_L0.py \
--run_simulator \
--config_simulator_path './src/config/test_simulator.yaml' \
--config_dataset_path './src/config/test_dataset.yaml' \
--config_train_path './src/config/test_train.yaml' \
--log_dir './src/train/log_test' \
--gpu \
-y
echo 'finished simulation'
