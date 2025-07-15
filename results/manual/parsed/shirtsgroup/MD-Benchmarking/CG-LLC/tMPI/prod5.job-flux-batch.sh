#!/bin/bash
#FLUX: --job-name=grated-cupcake-4815
#FLUX: --urgency=16

export GMX_MAXBACKUP='-1  # do not make back-ups'
export GMX_MAXCONSTRWARN='-1'

module load gcc
source /jet/home/susa/pkgs/gromacs/2020.5/bin/GMXRC
export GMX_MAXBACKUP=-1  # do not make back-ups
export GMX_MAXCONSTRWARN=-1
gmx mdrun -v -s prod.tpr -o prod -g nt16_nopm1.log -nt 16  -ntomp 1
