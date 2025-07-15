#!/bin/bash
#FLUX: --job-name=peierls
#FLUX: --queue=cm3atou
#FLUX: -t=43200
#FLUX: --priority=16

cd ${SLURM_SUBMIT_DIR}
module load intel/2022a
echo "begin lammps"
echo "the job is ${SLURM_JOB_ID}"
rm -f strain-stress dump.*
mpirun ~/software/lammps-cms/src/lmp_mpi -in lmp_peierls.in
echo "lammps out"
