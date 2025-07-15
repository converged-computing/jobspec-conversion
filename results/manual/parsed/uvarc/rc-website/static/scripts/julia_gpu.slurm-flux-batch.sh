#!/bin/bash
#FLUX: --job-name=buttery-punk-6057
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --priority=16

echo 'slurm allocates gpus ' $CUDA_VISIBLE_DEVICES
module purge
module load julia/1.5.0 cuda/10.2.89
julia gpuTest1.jl
