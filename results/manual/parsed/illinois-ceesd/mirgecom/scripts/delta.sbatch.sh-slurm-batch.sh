#!/bin/bash
#SBATCH --account=bbkf-delta-gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=4
#SBATCH --no-requeue

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
