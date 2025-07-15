#!/bin/bash
#FLUX: --job-name=cloudmask-gpu-greene
#FLUX: --queue=bii-gpu
#FLUX: -t=21600
#FLUX: --priority=16

export USER_SCRATCH='/scratch/$USER'
export PROJECT_DIR='$USER_SCRATCH/mlcommons/benchmarks/cloudmask'
export PYTHON_DIR='$USER_SCRATCH/ENV3'
export PROJECT_DATA='$USER_SCRATCH/data'

export USER_SCRATCH=/scratch/$USER
export PROJECT_DIR=$USER_SCRATCH/mlcommons/benchmarks/cloudmask
export PYTHON_DIR=$USER_SCRATCH/ENV3
export PROJECT_DATA=$USER_SCRATCH/data
module purge
module load singularity tensorflow/2.8.0
source $PYTHON_DIR/bin/activate
which python
nvidia-smi
cd $PROJECT_DIR/experiments/rivanna
cms gpu watch --gpu=0 --delay=0.5 --dense > outputs/gpu0.log &
singularity run --nv $CONTAINERDIR/tensorflow-2.8.0.sif "python slstr_cloud.py --config config.yaml"
seff $SLURM_JOB_ID
