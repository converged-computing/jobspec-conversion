#!/bin/bash
#FLUX: --job-name=cas9_nvt
#FLUX: -c=16
#FLUX: -t=36000
#FLUX: --urgency=16

export OMP_NUM_THREADS='16'

module load gromacs/2020.4
export OMP_NUM_THREADS=16
gmx mdrun -s cas9_prod0.tpr -v -ntmpi 1 -deffnm cas9_prod0
