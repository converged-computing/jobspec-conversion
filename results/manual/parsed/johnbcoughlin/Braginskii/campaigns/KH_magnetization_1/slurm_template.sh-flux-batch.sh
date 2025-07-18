#!/bin/bash
#FLUX: --job-name=KH-magnetization-1
#FLUX: -c=2
#FLUX: --gpus-per-task=1
#FLUX: --queue=ckpt
#FLUX: -t=172800
#FLUX: --urgency=16

export OPENBLAS_NUM_THREADS='1'

module use ~/modulefiles
module load julia
export OPENBLAS_NUM_THREADS=1
julia --version
julia --project=../.. --startup-file=no main.jl --run $SLURM_ARRAY_TASK_ID
