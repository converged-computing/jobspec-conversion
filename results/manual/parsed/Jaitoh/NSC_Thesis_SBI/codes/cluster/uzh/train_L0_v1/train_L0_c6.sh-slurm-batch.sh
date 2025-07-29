#!/bin/bash
#SBATCH --job-name=train_L0_c6
#SBATCH --output=./cluster/uzh/train_L0_v1/train_logs/train_L0_c6.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:T4:1
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00

module load anaconda3
source activate sbi
module load t4
module load cuda
python3 -u ./src/train/train_L0.py \
--config_simulator_path './src/config/simulator_Ca_Pb_Ma.yaml' \
--config_dataset_path './src/config/dataset_Sa0_suba0_Rb0.yaml' \
--config_train_path './src/config/train_Ta1.yaml' \
--log_dir './src/train/logs/log-train_L0-c6' \
--gpu \
-y > ./cluster/uzh/train_L0_v1/train_logs/train_L0_c6.log
echo 'finished simulation'
