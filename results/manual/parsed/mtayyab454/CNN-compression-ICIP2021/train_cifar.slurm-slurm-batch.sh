#!/bin/bash
#SBATCH --output=cifar/logs/%J.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00

date
echo "Slurm nodes: $SLURM_JOB_NODELIST"
NUM_GPUS=`echo $GPU_DEVICE_ORDINAL | tr ',' '\n' | wc -l`
echo "You were assigned $NUM_GPUS gpu(s)"
module load anaconda/anaconda3
module listr
nvidia-smi topo -m
echo
source activate my-pytorch
echo
time python train_cifar.py \
--jobid $SLURM_JOB_ID \
--arch resnet56 \
--dataset cifar10 \
--compress-rate 0.63 \
--l2-weight 0.001 \
--add-bn True \
--epochs 120 \
--schedule 30 60 90 \
--lr 0.01
echo
echo "Ending script..."
date
