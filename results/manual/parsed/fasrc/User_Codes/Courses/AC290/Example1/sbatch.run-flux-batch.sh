#!/bin/bash
#FLUX: --job-name=delicious-general-1295
#FLUX: --priority=16

WORK_DIR=/scratch/${USER}/${SLURM_JOB_ID}
PRO=mpi_hello
mkdir -pv ${WORK_DIR}
cd $WORK_DIR
cp ${SLURM_SUBMIT_DIR}/${PRO}.x .
module load gcc/8.2.0-fasrc01 openmpi/3.1.1-fasrc01 
srun -n $SLURM_NTASKS --mpi=pmix ./${PRO}.x > ${PRO}.dat
cp *.dat ${SLURM_SUBMIT_DIR}
rm -rf ${WORK_DIR}
