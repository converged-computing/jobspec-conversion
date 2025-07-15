#!/bin/bash
#FLUX: --job-name=faux-pedo-9762
#FLUX: --urgency=16

export PYTHONPATH='PYTHONPATH:$HOME/python_projects/'

hostname
root=/home/xxzh/auto_test/mylib
export PYTHONPATH=PYTHONPATH:$HOME/python_projects/
module purge
module load cuda/9.2
conda init
conda activate tf-gpu
nvcc --version
timeout 2 nvidia-smi
python hyper_parameter_search.py
