#!/bin/bash
#FLUX: --job-name=XXXXX
#FLUX: -t=345600
#FLUX: --priority=16

module load module load cp2k/9.1.0 python/3.9.0 mpi/openmpi_4.0.5_gcc_10.2_slurm20 gcc/8.3 cuda/11.1.1
source $CP2KSETUP
srun --mpi=pmix cp2k.popt -i traj_1.inp -o traj_1.out
