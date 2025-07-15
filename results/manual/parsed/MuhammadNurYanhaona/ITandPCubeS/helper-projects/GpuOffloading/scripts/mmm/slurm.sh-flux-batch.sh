#!/bin/bash
#FLUX: --job-name=bricky-parrot-9779
#FLUX: -t=3600
#FLUX: --priority=16

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
