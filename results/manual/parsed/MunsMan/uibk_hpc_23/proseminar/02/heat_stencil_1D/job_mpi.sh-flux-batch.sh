#!/bin/bash
#FLUX: --job-name=heat-mpi
#FLUX: -n=64
#FLUX: --exclusive
#FLUX: --queue=lva
#FLUX: --priority=16

module load openmpi/4.1.4-oneapi-2022.2.1-oj6kipv
mpirun -np $SLURM_NTASKS --mca btl_openib_allow_ib 1 ~/a.out 16384
