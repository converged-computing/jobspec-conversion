#!/bin/bash
#SBATCH --job-name=gpu_c2
#SBATCH --output=myjob.%j.out
#SBATCH --error=myjob.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100-sxm2:1
#SBATCH --mem=48GB
#SBATCH --time=08:00:00
#SBATCH --partition=gpu

conda create --name pytorch_env python=3.10 -y
source activate pytorch_env
conda install scikit-image pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia -y
pip install joblib matplotlib numpy pandas scikit-learn scipy seaborn
python new_test_cifar2.py
