#!/bin/bash
#FLUX: --job-name=salted-staircase-0318
#FLUX: -t=172740
#FLUX: --priority=16

echo "== Starting run at $(date)"
echo "== Job ID: ${SLURM_JOBID}, Task ID: ${SLURM_ARRAY_TASK_ID}"
echo "== Node list: ${SLURM_NODELIST}"
echo "== Submit dir. : ${SLURM_SUBMIT_DIR}"
VALUES=(ROS Jitter TW SMOTE ADASYN)
conda activate da
python main_100.py $1 ROCKET ${VALUES[$SLURM_ARRAY_TASK_ID]} 01 2  10 
