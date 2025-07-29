#!/bin/bash
#SBATCH --account=def-abhamza
#SBATCH --output=./logs/log.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100l:1
#SBATCH --mem=64GB
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=8

module load cuda cudnn 
nvidia-smi
source /home/hasib/projects/def-abhamza/hasib/envs/gpu/bin/activate
cd scripts
python train_seg.py
