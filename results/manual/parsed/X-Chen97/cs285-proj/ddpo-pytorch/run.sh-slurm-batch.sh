#!/bin/bash
#SBATCH --job-name=rl_test
#SBATCH --account=pc_automat
#SBATCH --mail-user=chenxin0210@lbl.gov
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:4
#SBATCH --time=04:00:00
#SBATCH --partition=es1
#SBATCH --qos=es_lowprio
#SBATCH --constraint=es1_a40

echo current conda env is $CONDA_DEFAULT_ENV
echo "================"
echo current GPU condition is:
python gpu.py
echo available nCPU is:
nproc
echo "================"
echo start running:
accelerate launch scripts/train.py --config config/dgx.py:gender_equality
