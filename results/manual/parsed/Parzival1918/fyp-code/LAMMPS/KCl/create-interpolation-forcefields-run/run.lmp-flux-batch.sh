#!/bin/bash
#FLUX: --job-name=system
#FLUX: -N=2
#FLUX: -t=108000
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

module purge
module load intel/2022b
export OMP_NUM_THREADS=1
srun --export=ALL --unbuffered --distribution=block:block --hint=nomultithread --exact \
/users/mta20pj/bin/lmp_stanage_03Mar2020_PLUMED -in input.lmp > screen.lmp
