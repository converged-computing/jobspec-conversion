#!/bin/bash
#FLUX: --job-name=week02
#FLUX: -n=64
#FLUX: --queue=lva
#FLUX: --urgency=16

module load openmpi/3.1.6-gcc-12.2.0-d2gmn55
mpiexec -np $SLURM_NTASKS ./heat_stencil_1D_mpi 4096
