#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem-per-cpu=2048
#SBATCH --time=2-00:00:00
#SBATCH --nodelist=gnode39

source ~/anaconda3/bin/activate
conda activate DRACO
cd /home/rahulsajnani/research/DRACO-Weakly-Supervised-Dense-Reconstruction-And-Canonicalization-of-Objects/DRACO
CUDA_VISIBLE_DEVICES=0,1,2,3 python main.py
