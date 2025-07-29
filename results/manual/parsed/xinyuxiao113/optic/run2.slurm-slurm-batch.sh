#!/bin/bash
#SBATCH --job-name=test2
#SBATCH --output=./out/test2.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=40G
#SBATCH --time=2-00:00:00
#SBATCH --qos=short

module load spack
module add cuda-11.4.2-gcc-11.2.0-rxy4qhm            # 载入 CUDA 9.0 模块
module add cudnn-8.2.4.15-11.4-gcc-11.2.0-a6q32ad
module add gcc/11.2.0  
module add anaconda           # 载入 anaconda 模块
source ~/.bashrc
conda activate commplax
python simulation.py  --seed 3214 --dz 0.002  --power 6 -6  --path /home/xiaoxinyu/data/0912test_dz_2m
