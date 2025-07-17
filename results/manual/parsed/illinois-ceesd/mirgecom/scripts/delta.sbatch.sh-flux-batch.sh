#!/bin/bash
#FLUX: --job-name=psycho-egg-2614
#FLUX: --gpus-per-task=1
#FLUX: --exclusive
#FLUX: --queue=gpuA40x4
#FLUX: -t=1800
#FLUX: --urgency=16

export PYOPENCL_CTX='port:nvidia"     # Run on Nvidia GPU with pocl'
export XDG_CACHE_HOME_ROOT='${MIRGE_CACHE_ROOT}/xdg-cache/rank'

export PYOPENCL_CTX="port:nvidia"     # Run on Nvidia GPU with pocl
nnodes=$SLURM_JOB_NUM_NODES
nproc=$SLURM_NTASKS
echo nnodes=$nnodes nproc=$nproc
srun_cmd="srun -N $nnodes -n $nproc"
MIRGE_CACHE_ROOT=${MIRGE_CACHE_ROOT:-"$(pwd)/.mirge-cache/"}
export XDG_CACHE_HOME_ROOT="${MIRGE_CACHE_ROOT}/xdg-cache/rank"
$srun_cmd bash -c 'XDG_CACHE_HOME=$XDG_CACHE_HOME_ROOT$SLURM_PROCID python -u -O -m mpi4py ./pulse.py'
