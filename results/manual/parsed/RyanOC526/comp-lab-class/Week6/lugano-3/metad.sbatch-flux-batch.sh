#!/bin/bash
#FLUX: --job-name=metad
#FLUX: -t=14400
#FLUX: --priority=16

source /scratch/work/courses/CHEM-GA-2671-2022fa/software/gromacs-2019.6-plumedSept2020/bin/GMXRC.bash.modules
gmx_mpi mdrun -s topol.tpr -nsteps 5000000 -plumed plumed.dat 
