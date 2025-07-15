#!/bin/bash
#FLUX: --job-name=xtc
#FLUX: -c=8
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --priority=16

export MPLCONFIGDIR='./envs/$PROJECT_NAME/.cache/matplotlib/'
export HF_DATASETS_CACHE='./envs/$PROJECT_NAME/.cache/huggingface/'

PROJECT_NAME="xtc"
module load 2022r2
module load miniconda3/4.12.0
module load cuda/11.7
export MPLCONFIGDIR="./envs/$PROJECT_NAME/.cache/matplotlib/"
export HF_DATASETS_CACHE="./envs/$PROJECT_NAME/.cache/huggingface/"
previous=$(/usr/bin/nvidia-smi --query-accounted-apps='gpu_utilization,mem_utilization,max_memory_usage,time' --format='csv' | /usr/bin/tail -n '+2')
conda env create --file environment.yml --name $PROJECT_NAME
conda activate $PROJECT_NAME
srun python CodeCompletion.py > code_completion_$PROJECT_NAME.log
/usr/bin/nvidia-smi --query-accounted-apps='gpu_utilization,mem_utilization,max_memory_usage,time' --format='csv' | /usr/bin/grep -v -F "$previous"
