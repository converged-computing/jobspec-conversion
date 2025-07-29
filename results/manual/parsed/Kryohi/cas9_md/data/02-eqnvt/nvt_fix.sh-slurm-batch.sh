#!/bin/bash
#FLUX: --job-name=cas9_nvt
#FLUX: -c=16
#FLUX: -t=10800
#FLUX: --urgency=16

export OMP_NUM_THREADS='16'

module load gromacs/2020.4
export OMP_NUM_THREADS=16
gmx mdrun -s nvt_fix.tpr -v -ntmpi 1 -deffnm mark_cas9_nvt 
