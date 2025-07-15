#!/bin/bash
#FLUX: --job-name=creamy-despacito-3161
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

module purge
module load mpi/openmpi-x86_64
export OMP_NUM_THREADS=1
cd $SLURM_SUBMIT_DIR
mpirun -n $SLURM_NTASKS -x OMP_NUM_THREADS -wdir $SLURM_SUBMIT_DIR ./PhononSED.x > SED_$SLURM_JOBID.out
