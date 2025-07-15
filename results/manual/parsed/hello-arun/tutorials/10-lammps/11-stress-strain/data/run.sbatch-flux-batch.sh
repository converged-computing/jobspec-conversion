#!/bin/bash
#FLUX: --job-name=joyous-citrus-0413
#FLUX: --queue=batch
#FLUX: -t=18000
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

module load openmpi/4.0.3
module load gcc/11.1.0
lmp_ibex="/ibex/scratch/jangira/lammps/sw/lammps-16Feb2016/openmpi/4.0.3/gcc/11.1.0/src/lmp_mpi"
export OMP_NUM_THREADS=1
mpirun -np ${SLURM_NPROCS} ${lmp_ibex} -in INCAR.lmp
