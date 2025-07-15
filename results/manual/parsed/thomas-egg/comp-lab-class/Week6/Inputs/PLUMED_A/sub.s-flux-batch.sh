#!/bin/bash
#FLUX: --job-name=structure_A
#FLUX: -t=3600
#FLUX: --priority=16

module purge
source /scratch/work/courses/CHEM-GA-2671-2023fa/software/gromacs-2019.6-plumedSept2020/bin/GMXRC.bash.modules
gmx_mpi mdrun -s topolA.tpr -nsteps 10000000
