#!/bin/bash
#FLUX: --job-name=finetune
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --urgency=16

module purge                        # 清除所有已加载的模块
module load anaconda3 cuda/11.1.1              # 加载anaconda (load virtual env for training)
nvidia-smi
nvcc --version
cd /gpfsnyu/scratch/yw3642/chaii/working/src     # 切到程序目录
echo "START"               # 输出起始信息
source deactivate
source /gpfsnyu/packages/anaconda3/5.2.0/bin/activate kaggle          # 调用 virtual env
python -u finetune.py                     # 用python跑代码
echo "FINISH"                       # 输出起始信息
