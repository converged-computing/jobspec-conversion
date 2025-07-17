#!/bin/bash
#FLUX: --job-name=mmult
#FLUX: -n=4
#FLUX: --queue=shared
#FLUX: -t=30
#FLUX: --urgency=16

WORK_DIR=/scratch/${USER}/${SLURM_JOB_ID}
PRO=mmult
mkdir -pv ${WORK_DIR}
cd $WORK_DIR
cp ${SLURM_SUBMIT_DIR}/${PRO}.x .
module load gcc/8.2.0-fasrc01
module load openmpi/3.1.1-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./${PRO}.x > ${PRO}.dat
cp *.dat ${SLURM_SUBMIT_DIR}
rm -rf ${WORK_DIR}
