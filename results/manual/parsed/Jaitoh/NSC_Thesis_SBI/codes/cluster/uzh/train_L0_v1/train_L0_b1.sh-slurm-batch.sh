#!/bin/bash
#SBATCH --job-name=dataset_gen
#SBATCH --output=./cluster/train_L0/train_L0_b1.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:T4:1
#SBATCH --mem=12G
#SBATCH --time=1-00:00:00

module load anaconda3
source activate sbi
module load t4
module load cuda
python3 -u ./src/train/train_L0.py \
--config_simulator_path './src/config/simulator_Ca_Pb_Ma.yaml' \
--config_dataset_path './src/config/dataset_Sb0_suba1_Ra0.yaml' \
--config_train_path './src/config/train_Ta1.yaml' \
--log_dir './src/train/logs/log-simulator_Ca_Pb_Ma-dataset_Sb0_suba1_Ra0-train_Ta1' \
--gpu \
> ./cluster/train_L0/train_L0_b1.log
echo 'finished simulation'
