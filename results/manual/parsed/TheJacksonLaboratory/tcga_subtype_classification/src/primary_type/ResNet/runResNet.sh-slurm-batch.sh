#!/bin/bash
#SBATCH --job-name=ResNet
#SBATCH --output=./output/currentResNet
#SBATCH --mail-user=yue.zhao@jax.org
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=100gb
#SBATCH --time=4-04:00:00

alpha=0.01
dataSet=tumor_type
num_epochs=1000
batch_size=128
random_seed=1024
num_feature=254
nn_structure=200_128_32
dropout_keep_rate=${1}
treat=ResNet_DEG_Feature_1000_smote_orderChromo_Best
python ResNet/ExternalTest.py --data_set=tumor_type --treat=${treat}
