#!/bin/bash
#FLUX: --job-name=gsfe
#FLUX: --queue=cm3atou
#FLUX: -t=43200
#FLUX: --urgency=16

cd ${SLURM_SUBMIT_DIR}
module load intel/2022a
echo "begin lammps"
echo "the job is ${SLURM_JOB_ID}"
rm -f gsfe gsfe_ori
mpirun ~/software/lammps-cms/src/lmp_mpi -in lmp_gsfe.in
echo "lammps out"
