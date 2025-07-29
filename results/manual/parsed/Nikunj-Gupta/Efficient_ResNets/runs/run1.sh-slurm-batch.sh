#!/bin/bash
#SBATCH --job-name=se_fulldrop_good_ResNet4_num_blocks1x1x1x1_squeeze_and_excitation0_drop0
#SBATCH --output=se_fulldrop_good_ResNet4_num_blocks1x1x1x1_squeeze_and_excitation0_drop0.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=40GB
#SBATCH --time=02:00:00

module load python/intel/3.8.6
module load openmpi/intel/4.0.5
source ../venvs/dl/bin/activate
time python3 main.py  --config resnet_configs/se_fulldrop_good_ResNet4.yaml --resnet_architecture se_fulldrop_good_ResNet4_num_blocks1x1x1x1_squeeze_and_excitation0_drop0
