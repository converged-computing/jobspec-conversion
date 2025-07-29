#!/bin/bash
#SBATCH --job-name=dataset_gen
#SBATCH --output=./cluster/train_L0.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=16G
#SBATCH --time=1-00:00:00

module load anaconda3
source activate sbi
python3 -u ./src/train/train_L0.py \
--config_simulator_path './src/config/simulator_Ca_Pb_Ma.yaml' \
--config_dataset_path './src/config/dataset_Sa0_suba1_Ra1.yaml' \
--config_train_path './src/config/train_Ta1.yaml' \
--log_dir './src/train/logs/log-simulator_Ca_Pb_Ma-dataset_Sa0_suba1_Ra1-train_Ta1' \
> ./cluster/train_L0/train_L0_a2.log
echo 'finished simulation'
