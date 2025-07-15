#!/bin/bash
#FLUX: --job-name=red-omelette-5286
#FLUX: --queue=gpu_7d1g
#FLUX: --priority=16

echo "Submitted from:"$SLURM_SUBMIT_DIR" on node:"$SLURM_SUBMIT_HOST
echo "Running on node "$SLURM_JOB_NODELIST 
echo "Allocate Gpu Units:"$CUDA_VISIBLE_DEVICES
source /home/xiaoqiguo2/.bashrc
module load cuda/10.2.89
conda activate torch
cd /home/xiaoqiguo2/L2uDT/experiment/Ours/
python ./train_SoCL.py
