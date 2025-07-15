#!/bin/bash
#FLUX: --job-name=placid-platanos-9929
#FLUX: --priority=16

echo "Submitted from:"$SLURM_SUBMIT_DIR" on node:"$SLURM_SUBMIT_HOST
echo "Running on node "$SLURM_JOB_NODELIST 
echo "Allocate Gpu Units:"$CUDA_VISIBLE_DEVICES
source /home/xiaoqiguo2/.bashrc
conda activate torch020
cd /home/xiaoqiguo2/Class2affinity/tools_ablation/
python ./VolMin.py
