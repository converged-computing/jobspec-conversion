#!/bin/bash
#FLUX: --job-name=run-gromacs
#FLUX: -t=14400
#FLUX: --priority=16

module load gromacs/openmpi/intel/2018.3
gmx_mpi grompp -f adp_T350.mdp -c adp.gro  -p adp.top -o adp_T350.tpr
gmx_mpi mdrun -deffnm adp_T350
