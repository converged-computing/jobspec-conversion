#!/bin/bash
#FLUX: --job-name=flipflop-array
#FLUX: -t=86340
#FLUX: --urgency=16

echo "My SLURM_ARRAY_JOB_ID is $SLURM_ARRAY_JOB_ID"
echo "My SLURM_ARRAY_TASK_ID is $SLURM_ARRAY_TASK_ID"
echo "Executing on the machine:" $(hostname)
module purge
module load julia/1.6.1 cudatoolkit/11.0 cudnn/cuda-11.0/8.0.2
julia n_bit_flipflop/three_bit/original/n_bit_flipflop_disc_time_array.jl
