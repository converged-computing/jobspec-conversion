#!/bin/bash
#FLUX: --job-name=wobbly-house-9236
#FLUX: -n=2
#FLUX: -t=60
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

echo $SLURM_JOB_NODELIST
cd $SLURM_SUBMIT_DIR
export OMP_NUM_THREADS=1
srun --mpi=pmix --cpu_bind=verbose,core -c $OMP_NUM_THREADS -n 2 ./a.out > intra_node.dat
