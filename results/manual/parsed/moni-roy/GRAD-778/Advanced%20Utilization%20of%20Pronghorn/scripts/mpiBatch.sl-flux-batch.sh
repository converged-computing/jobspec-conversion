#!/bin/bash
#FLUX: --job-name=myFirstMPIJob
#FLUX: -c=2
#FLUX: --queue=cpu-core-0
#FLUX: -t=60
#FLUX: --urgency=16

export OMP_NUM_THREADS='2'

export OMP_NUM_THREADS=2
module load openmpi/gcc/4.0.4 
module load singularity 
mpirun singularity exec lammps_latest.sif lmp_mpi < input.lammps
