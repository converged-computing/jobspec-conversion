#!/bin/bash
#FLUX: --job-name=confused-leg-0470
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

module load openmpi/3.1.5/gcc-9.3.0
export OMP_NUM_THREADS=1
echo $OMP_NUM_THREADS > output-np$SLURM_NTASKS
echo $SLURM_NTASKS >> output-np$SLURM_NTASKS
julia --version >> output-np$SLURM_NTASKS
mpirun -np $SLURM_NTASKS julia --project=@. run.jl >> output-np$SLURM_NTASKS
