#!/bin/bash
#FLUX: --job-name=moolicious-animal-9286
#FLUX: -t=900
#FLUX: --priority=16

export OMP_NUM_THREADS='4'
export MPICH_MAX_THREAD_SAFETY='multiple'

export OMP_NUM_THREADS=4
export MPICH_MAX_THREAD_SAFETY=multiple
my_inputs=$@
srun -n 1 python ~/Repo/MAESTROeX/Exec/science/urca/analysis/scripts/volume-plot-rad_vel.py $my_inputs
