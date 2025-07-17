#!/bin/bash
#FLUX: --job-name=stage_2_ref_free
#FLUX: -c=4
#FLUX: --queue=cpu-512
#FLUX: -t=82800
#FLUX: --urgency=16

nvidia-smi
nvcc --version
cd /l/users/yichen.huang/simplification-eval/code   # 切到程序目录
echo "START"               # 输出起始信息
source /apps/local/anaconda3/bin/activate tim          # 调用 virtual env
python -u make_ref_based_supervision.py
echo "FINISH"                       # 输出起始信息
