#!/bin/bash
#SBATCH --mail-user=feisi@meta.com
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --time=14-00:00:00

for i in 1 2 3 4 5
do
     for batch in 1024 2048
     do
          python main.py --quan 1 --world-size 8 --rank 0 --workers 64 --batch-size $batch --arch resnet50
     done
done
