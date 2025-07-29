#!/bin/bash
#SBATCH --job-name=stage_2_ref_free
#SBATCH --output=./logs/stage2/%x%A.out
#SBATCH --error=./logs/stage2/%x%A.err
#SBATCH --mail-user=yh2689@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=64GB
#SBATCH --time=23:00:00
#SBATCH --partition=cpu-512

nvidia-smi
nvcc --version
cd /l/users/yichen.huang/simplification-eval/code   # 切到程序目录
echo "START"               # 输出起始信息
source /apps/local/anaconda3/bin/activate tim          # 调用 virtual env
python -u make_ref_based_supervision.py
echo "FINISH"                       # 输出起始信息
