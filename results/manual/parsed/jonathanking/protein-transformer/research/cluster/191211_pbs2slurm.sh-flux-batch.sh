#!/bin/bash
#FLUX: --job-name=pt-sweep
#FLUX: --queue=dept_gpu
#FLUX: -t=2419200
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
conda activate pytorch-build
cd $SLURM_SUBMIT_DIR
cmd="$(sed -n "${SLURM_ARRAY_TASK_ID}p" research/cluster/191211_test.txt)"
echo $cmd
eval $cmd
exit 0
