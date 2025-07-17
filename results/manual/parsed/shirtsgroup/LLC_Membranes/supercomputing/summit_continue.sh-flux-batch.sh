#!/bin/bash
#FLUX: --job-name=fat-egg-5230
#FLUX: --queue=sgpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load gromacs/2018_gpu
mpirun -np 4 gmx_mpi mdrun -s PR.tpr -cpi PR.cpt -append -v -deffnm PR
