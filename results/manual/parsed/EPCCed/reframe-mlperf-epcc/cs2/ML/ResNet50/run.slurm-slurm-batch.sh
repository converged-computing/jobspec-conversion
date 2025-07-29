#!/bin/bash
#SBATCH --job-name=mlperf-ResNet
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=cs:1
#SBATCH --time=12:00:00

source /home/z043/z043/crae-cs1/mlperf_cs2_pt/bin/activate
python /home/z043/z043/crae-cs1/chris-ml-intern/cs2/ML/ResNet50/train.py
