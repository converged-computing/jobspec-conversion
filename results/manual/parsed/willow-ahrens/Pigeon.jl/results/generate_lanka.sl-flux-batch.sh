#!/bin/bash
#FLUX: --job-name=blue-kitty-9332
#FLUX: --exclusive
#FLUX: --queue=lanka-v3
#FLUX: --urgency=16

export SCRATCH='/data/scratch/pahrens'
export PATH='$SCRATCH/julia:$PATH'
export JULIA_DEPOT_PATH='/data/scratch/pahrens/.julia'
export MATRIXDEPOT_DATA='/data/scratch/pahrens/MatrixData'
export LD_LIBRARY_PATH='/data/scratch/pahrens/taco/build/lib:$LD_LIBRARY_PATH'

export SCRATCH=/data/scratch/pahrens
export PATH="$SCRATCH/julia:$PATH"
export JULIA_DEPOT_PATH=/data/scratch/pahrens/.julia
export MATRIXDEPOT_DATA=/data/scratch/pahrens/MatrixData
export LD_LIBRARY_PATH=/data/scratch/pahrens/taco/build/lib:$LD_LIBRARY_PATH
cd $SCRATCH/Pigeon.jl/results
echo "Starting Job: $SLURM_ARRAY_JOB_ID, $SLURM_ARRAY_TASK_ID"
echo turboboostcheck
cat /sys/devices/system/cpu/intel_pstate/no_turbo
if [[ $SLURM_ARRAY_TASK_ID -eq 1 ]]
then
  srun --cpu-bind=sockets julia --project=. spgemm.jl
elif [[ $SLURM_ARRAY_TASK_ID -eq 2 ]]
then
  srun --cpu-bind=sockets julia --project=. spgemm2.jl
elif [[ $SLURM_ARRAY_TASK_ID -eq 3 ]]
then
  srun --cpu-bind=sockets julia --project=. spgemmh.jl
elif [[ $SLURM_ARRAY_TASK_ID -eq 4 ]]
then
  srun --cpu-bind=sockets julia --project=. spmv.jl
elif [[ $SLURM_ARRAY_TASK_ID -eq 5 ]]
then
  srun --cpu-bind=sockets julia --project=. spmv2.jl
elif [[ $SLURM_ARRAY_TASK_ID -eq 6 ]]
then
  srun --cpu-bind=sockets julia --project=. smttkrp.jl
fi
