#!/bin/bash
#FLUX: --job-name=butterscotch-dog-5641
#FLUX: -c=14
#FLUX: --gpus-per-task=2
#FLUX: --queue=small-g
#FLUX: -t=3600
#FLUX: --urgency=16

export DATADIR='$COURSE_SCRATCH/data'
export TORCH_HOME='$COURSE_SCRATCH/torch-cache'
export HF_HOME='$COURSE_SCRATCH/hf-cache'
export MLFLOW_TRACKING_URI='$COURSE_SCRATCH/data/users/$USER/mlruns'

module purge
module use /appl/local/csc/modulefiles/
module load pytorch
COURSE_SCRATCH="/scratch/${SLURM_JOB_ACCOUNT}"
export DATADIR=$COURSE_SCRATCH/data
export TORCH_HOME=$COURSE_SCRATCH/torch-cache
export HF_HOME=$COURSE_SCRATCH/hf-cache
export MLFLOW_TRACKING_URI=$COURSE_SCRATCH/data/users/$USER/mlruns
set -xv
python3 $*
