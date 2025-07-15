#!/bin/bash
#FLUX: --job-name=archive_deployment
#FLUX: -N=10
#FLUX: -t=7200
#FLUX: --priority=16

module swap PrgEnv-cray PrgEnv-gnu
module load python/2.7.10
module load mpi4py
APP_ROOT="/scratch2/mwaops/cwu/dfms"
SID=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_DIR=$APP_ROOT"/logs/"$SID
mkdir -m $LOG_DIR # to remove potential directory creation conflicts later
aprun -B /home/cwu/dfms_env/bin/python $APP_ROOT"/cluster/start_dfms_cluster.py" -l $LOG_DIR -g 7 -d
