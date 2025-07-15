#!/bin/bash
#FLUX: --job-name=focalpose
#FLUX: -N=5
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

export PYTHONPATH='$(pwd)'
export JOB_DIR='local_data/run_$1'

module purge
module load Anaconda3/5.0.1 NCCL
. /opt/apps/software/Anaconda3/5.0.1/etc/profile.d/conda.sh
conda deactivate
conda activate focalpose
export PYTHONPATH=$(pwd)
export JOB_DIR=local_data/run_$1
if [ -d "$JOB_DIR" ]; then
  rm $JOB_DIR/*
else
  mkdir $JOB_DIR
fi
srun python -m focalpose.scripts.run_pose_training --config $2
