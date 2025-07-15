#!/bin/bash
#FLUX: --job-name=th_pr
#FLUX: -c=8
#FLUX: --queue=gpushort
#FLUX: -t=7200
#FLUX: --priority=16

echo starting_jobscript
module add CUDA/10.1.243-GCC-8.3.0
echo activating environment
source /data/p288722/python_venv/scd_images/bin/activate
nvidia-smi
python /home/p288722/git_code/scd_images/run_flow_2.py -fold ${SLURM_ARRAY_TASK_ID} -num_patches 200 -patch_aggregation "majority_vote" -use_contributing_patches 0 -patches_type "train_homo_test_random"
echo jobs completed
