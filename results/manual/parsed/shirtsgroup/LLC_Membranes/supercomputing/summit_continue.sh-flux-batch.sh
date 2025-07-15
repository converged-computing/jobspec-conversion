#!/bin/bash
#FLUX: --job-name=eccentric-mango-8833
#FLUX: --priority=16

module load gromacs/2018_gpu
mpirun -np 4 gmx_mpi mdrun -s PR.tpr -cpi PR.cpt -append -v -deffnm PR
