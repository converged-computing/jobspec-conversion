#!/bin/bash
#SBATCH --job-name=example
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00
#SBATCH --partition=res-gpu-small
#SBATCH --qos=short

source /etc/profile
source env/bin/activate
module load cuda/10.0-cudnn7.4
python -u example.py
