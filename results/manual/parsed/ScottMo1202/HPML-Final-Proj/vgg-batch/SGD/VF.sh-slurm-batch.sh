#!/bin/bash
#SBATCH --job-name=VF
#SBATCH --output=%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:rtx8000:2
#SBATCH --mem=160GB
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load anaconda3/2020.07
eval "$(conda shell.bash hook)"
conda activate key
module load python/intel/3.8.6
module load anaconda3/2020.07
cd /scratch/xm2100/final-proj/all-sh/VGG-SGD
python3 ../../run-googlenet.py --cuda --aug=VerticalFlip --model=vgg --numGPUs=2 --batchSize=32 --optimizer=sgd
