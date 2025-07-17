#!/bin/bash
#FLUX: --job-name=ivae-gpu
#FLUX: --queue=gpu
#FLUX: -t=360
#FLUX: --urgency=16

module add nvidia/9.0
source ~/.bashrc
conda activate deep
python main.py $(sed -n ${SLURM_ARRAY_TASK_ID}p args_gpu_seeded.txt)
