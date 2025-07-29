#!/bin/bash
#FLUX: --job-name=run-gromacs
#FLUX: -t=14400
#FLUX: --urgency=16

module load gromacs/openmpi/intel/2018.3
gmx_mpi grompp -f adp_T300.mdp -c adp.gro  -p adp.top -o adp_T300.tpr
gmx_mpi mdrun -deffnm adp_T300
