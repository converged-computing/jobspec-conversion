#!/bin/bash
#SBATCH --output=slurm_new_5.out
#SBATCH --error=slurm_new_5.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=3-00:12:00

module load tensorflow/1.8-agave-gpu
source ~/work/code/pytorch1_0/bin/activate
cd /home/tgokhale/work/code/e2e_resnet
python3 test.py --learning_rate 0.005 --loss_type mse --batch_size 64 --val_batch_size 64
