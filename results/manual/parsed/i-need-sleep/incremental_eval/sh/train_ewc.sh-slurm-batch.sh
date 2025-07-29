#!/bin/bash
#SBATCH --job-name=train_ewc
#SBATCH --output=./logs/%x%A.out
#SBATCH --error=./logs/%x%A.err
#SBATCH --mail-user=yh2689@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=256GB
#SBATCH --time=12:00:00
#SBATCH --qos=gpu-8

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/'
export HF_HOME='/l/users/yichen.huang/misc/cache'

nvidia-smi
nvcc --version
cd /l/users/yichen.huang/incremental_eval/code   # 切到程序目录
echo "START"               # 输出起始信息
source /apps/local/anaconda3/bin/activate adv          # 调用 virtual env
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/
export HF_HOME=/l/users/yichen.huang/misc/cache
python -u training.py \
    --name train_ewc \
    --strategy ewc \
    --batch_size 6 \
    --strategy_checkpoint ../results/checkpoints/train_ewc/exp_2_strat.pt
echo "FINISH"                       # 输出起始信息
