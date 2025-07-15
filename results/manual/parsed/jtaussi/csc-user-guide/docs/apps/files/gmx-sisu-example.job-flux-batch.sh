#!/bin/bash
#FLUX: --job-name=GMX
#FLUX: -N=4
#FLUX: --queue=test
#FLUX: -t=1800
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

(( ncores = SLURM_NNODES * 24 ))
export OMP_NUM_THREADS=1
module load gromacs/2018 # change to the desired version
aprun -n $ncores gmx mdrun_mpi -s topol -dlb yes -maxh 0.5
