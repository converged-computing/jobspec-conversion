#!/bin/bash
#SBATCH --job-name=width_cf100_dense_81624
#SBATCH --account=test
#SBATCH --output=width_cf100_dense_81624.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=1-12:00:00
#SBATCH --constraint=ntasks-per-node=1

source /home/TUE/20180170/miniconda3/etc/profile.d/conda.sh
source activate torch151
sparse_init=ERK
data=cifar10
for model in cifar_resnet_20 cifar_resnet_32 cifar_resnet_44 cifar_resnet_56 cifar_resnet_110
do
    python main.py --sparse --seed 17 --sparse_init ERK --fix --lr 0.1 --density 0.05 --model $model --data cifar10 --epoch 160
done
conda deactivate torch151
