#!/bin/bash
#FLUX: --job-name=train_ewc
#FLUX: -c=4
#FLUX: -t=43200
#FLUX: --urgency=16

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
