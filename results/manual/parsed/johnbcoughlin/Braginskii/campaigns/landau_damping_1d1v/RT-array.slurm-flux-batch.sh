#!/bin/bash
#FLUX: --job-name=RT-hybrid-vlasov-comparison-arrayjob
#FLUX: -c=2
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu-rtx6k
#FLUX: -t=86400
#FLUX: --priority=16

export OPENBLAS_NUM_THREADS='1'

module use ~/modulefiles
module load julia
export OPENBLAS_NUM_THREADS=1
julia --version
julia --project=../.. --startup-file=no main.jl --run $SLURM_ARRAY_TASK_ID
