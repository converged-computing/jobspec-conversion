#!/bin/bash
#FLUX: --job-name=reclusive-signal-0699
#FLUX: --urgency=16

module load gromacs/2018_gpu
mpirun -np 4 gmx_mpi mdrun -s PR.tpr -cpi PR.cpt -append -v -deffnm PR
