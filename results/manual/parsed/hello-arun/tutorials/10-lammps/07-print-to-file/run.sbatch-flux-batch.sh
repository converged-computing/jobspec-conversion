#!/bin/bash
#FLUX: --job-name=blank-blackbean-5357
#FLUX: --queue=batch
#FLUX: -t=7200
#FLUX: --priority=16

module load openmpi/4.0.3
module load gcc/11.1.0
lmp_ibex="/ibex/scratch/jangira/lammps/sw/lammps-16Feb2016/openmpi/4.0.3/gcc/11.1.0/src/lmp_mpi"
mpirun -np ${SLURM_NPROCS} ${lmp_ibex} -in INCAR.lmp
