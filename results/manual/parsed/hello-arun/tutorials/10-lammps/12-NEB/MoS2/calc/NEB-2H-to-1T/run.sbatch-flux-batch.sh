#!/bin/bash
#FLUX: --job-name=NEB-2H-1T
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

module load intel/2020
module load openmpi/4.0.3_intel
module load  lammps/29Sep2021/openmpi-4.0.3_intel2020
lmp_ibex=/sw/csi/lammps/29Sep2021/openmpi-4.0.3_intel2020/install/bin/lmp_ibex
export OMP_NUM_THREADS=1
mpirun -np ${SLURM_NPROCS} --oversubscribe ${lmp_ibex} -partition 7x16 -in INCAR.lmp
