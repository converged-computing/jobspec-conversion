#!/bin/bash
#SBATCH --mail-user=feisi@meta.com
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --time=14-00:00:00
#SBATCH --partition=train

for batch in 1024 2048 4096 8192
do
     python main.py --log_file main_log2.txt --epochs 5 --world-size 8 --rank 0 --workers 64 --batch-size $batch
done
for batch in 512 1024 2048
do
     python main.py --arch resnet50 --log_file main_log2.txt --epochs 5 --world-size 8 --rank 0 --workers 64 --batch-size $batch
done
