#!/bin/bash
#FLUX: --job-name=LAMMPS
#FLUX: -N=4
#FLUX: -n=8
#FLUX: -c=8
#FLUX: -t=345600
#FLUX: --urgency=16

export OMP_NUM_THREADS='8'

date
hostname
module load intel/2018 openmpi
export OMP_NUM_THREADS=8
srun --mpi=pmix_v2 /path/to/app/lmp_gator2 < in.Cu.v.24nm.eq_xrd
