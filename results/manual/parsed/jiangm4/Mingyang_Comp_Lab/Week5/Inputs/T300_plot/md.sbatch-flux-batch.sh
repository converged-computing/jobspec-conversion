#!/bin/bash
#FLUX: --job-name=run-gromacs
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load gromacs/openmpi/intel/2020.4
mpirun -np 1 gmx_mpi grompp -f adp_T300.mdp -c adp.gro -p adp.top -o md.tpr
mpirun -np 1 gmx_mpi mdrun -v -deffnm md
