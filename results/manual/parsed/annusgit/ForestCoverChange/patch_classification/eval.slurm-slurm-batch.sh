#!/bin/bash
#SBATCH --job-name=NN-FINN
#SBATCH --output=forest.out
#SBATCH --error=forest.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:K20Xm:1
#SBATCH --time=13:20:00

module load gcc/latest
module load nvidia/7.5
module load cudnn/7.5-v5
python train.py --function train_net --data_path tif/ --save_dir vgg5 --batch_size 256 --lr 0.0022 --log_after 5 --cuda 1 --device 0
