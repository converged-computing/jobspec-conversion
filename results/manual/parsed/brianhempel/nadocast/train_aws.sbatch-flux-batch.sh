#!/bin/bash
#FLUX: --job-name=outstanding-diablo-6238
#FLUX: --exclusive
#FLUX: -t=604800
#FLUX: --priority=16

export HOME='/home/brian.hempel'
export PATH='$PATH:$HOME/.local/bin:$HOME/bin'
export FORECAST_HOUR_RANGE='${FORECAST_HOUR_START}:${FORECAST_HOUR_STOP}'
export JULIA_MPI_BINARY='system'
export JULIA_MPI_PATH='/opt/amazon/openmpi'
export JULIA_MPI_LIBRARY='/opt/amazon/openmpi/lib64/libmpi'
export JULIA_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MUST_LOAD_FROM_DISK='true'
export DISTRIBUTED='true'

export HOME=/home/brian.hempel
export PATH=$PATH:$HOME/.local/bin:$HOME/bin
export FORECAST_HOUR_RANGE=${FORECAST_HOUR_START}:${FORECAST_HOUR_STOP}
export JULIA_MPI_BINARY=system
export JULIA_MPI_PATH=/opt/amazon/openmpi
export JULIA_MPI_LIBRARY=/opt/amazon/openmpi/lib64/libmpi
export JULIA_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MUST_LOAD_FROM_DISK=true
export DISTRIBUTED=true
cd $DATA_ROOT
pwd
env
cat /proc/cpuinfo
time mpirun --bind-to none julia --compiled-modules=no --project=/scratch/nadocast_dev /scratch/nadocast_dev/models/${SREF_OR_HREF}_mid_2018_forward/TrainGradientBoostedDecisionTrees.jl
