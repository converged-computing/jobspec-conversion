#!/bin/bash
#SBATCH --job-name=train_L0-e4
#SBATCH --output=./cluster/uzh/train_L0_v1/train_logs/train_L0-e4.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --time=1-00:00:00

module load intel
module load anaconda3
source activate sbi
module load t4
python3 -u ./src/train/train_L0.py \
--seed 0 \
--config_simulator_path './src/config/simulator_Ca_Pb_Ma.yaml' \
--config_dataset_path './src/config/dataset_Sb0_suba1_Ra0.yaml' \
--config_train_path './src/config/train_Ta1_5.yaml' \
--log_dir './src/train/logs/logs_L0_v1/log-train_L0-e4' \
--gpu \
-y > ./cluster/uzh/train_L0_v1/train_logs/train_L0-e4.log
echo 'finished simulation'
