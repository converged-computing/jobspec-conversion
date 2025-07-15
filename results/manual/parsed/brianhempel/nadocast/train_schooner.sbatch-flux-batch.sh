#!/bin/bash
#FLUX: --job-name=dirty-pot-4316
#FLUX: -N=25
#FLUX: -c=20
#FLUX: --exclusive
#FLUX: --queue=largejobs
#FLUX: -t=172800
#FLUX: --urgency=16

export HOME='/home/brianhempel'
export PATH='$PATH:$HOME/.local/bin:$HOME/bin'
export FORECAST_HOUR_RANGE='${FORECAST_HOUR_START}:${FORECAST_HOUR_STOP}'
export JULIA_MPI_BINARY='system'
export JULIA_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MUST_LOAD_FROM_DISK='true'
export DISTRIBUTED='true'

export HOME=/home/brianhempel
export PATH=$PATH:$HOME/.local/bin:$HOME/bin
module load zlib
module load PROJ
module load OpenMPI
export FORECAST_HOUR_RANGE=${FORECAST_HOUR_START}:${FORECAST_HOUR_STOP}
export JULIA_MPI_BINARY=system
export JULIA_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MUST_LOAD_FROM_DISK=true
export DISTRIBUTED=true
pwd
env
cat /proc/cpuinfo
time mpirun --bind-to none julia --compiled-modules=no --project=/home/brianhempel/nadocast_dev /home/brianhempel/nadocast_dev/models/${SREF_OR_HREF}_mid_2018_forward/TrainGradientBoostedDecisionTrees.jl
