#!/bin/bash
#FLUX: --job-name=E1B
#FLUX: -t=144000
#FLUX: --urgency=16

source /scratch/work/courses/CHEM-GA-2671-2022fa/software/gromacs-2019.6-plumedSept2020/bin/GMXRC.bash.modules
gmx_mpi mdrun -s topolB.tpr -nsteps 10000000
