#!/bin/bash
#FLUX: --job-name=structure_B
#FLUX: -t=86400
#FLUX: --priority=16

module purge
source /scratch/work/courses/CHEM-GA-2671-2023fa/software/gromacs-2019.6-plumedSept2020/bin/GMXRC.bash.modules
gmx_mpi mdrun -s topolB.tpr -nsteps 10000000
