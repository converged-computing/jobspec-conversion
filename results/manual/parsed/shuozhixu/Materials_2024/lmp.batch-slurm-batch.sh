#!/bin/bash
#FLUX: --job-name=Ag
#FLUX: -n=32
#FLUX: --queue=cm3atou
#FLUX: -t=604800
#FLUX: --urgency=16

cd ${SLURM_SUBMIT_DIR}
rm -f dump.* shear.*
module load intel/2022a
echo "begin lammps"
echo "the job is ${SLURM_JOB_ID}"
mpirun -np $SLURM_NPROCS ~/lammps-mbvo/mylammps/src/lmp_mpi -in lmp.in
echo "lammps out"
