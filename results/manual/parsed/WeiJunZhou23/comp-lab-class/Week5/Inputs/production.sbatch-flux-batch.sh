#!/bin/bash
#FLUX: --job-name=gromacs
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load gromacs/openmpi/intel/2018.3
srun -n 1 gmx_mpi grompp -f adp_T300.mdp -c adp.gro -p adp.top -o adp.tpr
srun -n 1 gmx_mpi mdrun -deffnm adp
