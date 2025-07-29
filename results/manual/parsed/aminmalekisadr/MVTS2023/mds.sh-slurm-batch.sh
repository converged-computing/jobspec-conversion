#!/bin/bash
#SBATCH --job-name=MVVGE-mds
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-user=mmalekis@uwaterloo.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:a100:1
#SBATCH --mem-per-cpu=20000
#SBATCH --time=7-00:00:00

echo "Cuda device: $CUDA_VISIBLE_DEVICES"
echo "======= Start memory test ======="
python main.py experiments/Config.yaml SMD mds
