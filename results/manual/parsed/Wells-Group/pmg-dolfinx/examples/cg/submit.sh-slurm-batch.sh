#!/bin/bash
#SBATCH --job-name=examplejob
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --time=00:10:00
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=8

export MPICH_GPU_SUPPORT_ENABLED='1'
export AMD_LOG_LEVEL='0'

export MPICH_GPU_SUPPORT_ENABLED=1
echo "Starting job $SLURM_JOB_ID at `date`"
ulimit -c unlimited
ulimit -s unlimited
gpu_bind=../select_gpu.sh
cpu_bind="--cpu-bind=map_cpu:49,57,17,23,1,9,33,41"
export AMD_LOG_LEVEL=0
export MPICH_GPU_SUPPORT_ENABLED=1
cd build
make -j8
srun -N ${SLURM_NNODES} -n ${SLURM_NTASKS} ${cpu_bind} ${gpu_bind} ./cg --ndofs 6000000
