#!/bin/bash
#FLUX: --job-name=JobName
#FLUX: -N=16
#FLUX: -t=600
#FLUX: --urgency=16

input_type=$1
processes=$2
array_size=$3
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
CALI_CONFIG="spot(output=Bubble-MPI-${input_type}-p${processes}-v${array_size}.cali, time.variance, topdown.toplevel)" \
mpirun -np $processes ./bubble_mpi $input_type $array_size
squeue -j $SLURM_JOBID
