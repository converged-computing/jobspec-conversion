#!/bin/bash
#FLUX: --job-name=__job-name
#FLUX: --queue=batch
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

module load lammps/29Sep2021/openmpi-4.0.3_intel2020
lmp_ibex="/sw/csi/lammps/29Sep2021/openmpi-4.0.3_intel2020/install/bin/lmp_ibex"
export OMP_NUM_THREADS=1
mpirun -np ${SLURM_NPROCS} ${lmp_ibex} -in INCAR.lmp
