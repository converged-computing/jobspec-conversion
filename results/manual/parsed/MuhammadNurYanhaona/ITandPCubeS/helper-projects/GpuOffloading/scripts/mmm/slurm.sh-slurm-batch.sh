#!/bin/bash
#SBATCH --output=output
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --time=01:00:00
#SBATCH --nodelist=artemis5

executable=../../gpu_offload.o
matrix_size=$1
block_size=$2
batch_size=$3
do_cpu_computation=$4
ulimit -c unlimited
pwd
nvidia-smi
hostname
mpirun.openmpi $executable $matrix_size $block_size $batch_size $do_cpu_computation
