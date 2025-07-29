#!/bin/bash
#FLUX: --job-name=slurm_gromacs_examplerun_long
#FLUX: -N=2
#FLUX: --queue=ccb
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module -q purge
module -q load modules/2.2-20230808
module -q load openmpi/cuda-4.0.7
module -q load gromacs/mpi-2023.1
module list
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
lscpu
nvidia-smi
numactl -H
mpirun --map-by socket:pe=$OMP_NUM_THREADS gmx_mpi mdrun -v -deffnm gromacs_examplerun_long
