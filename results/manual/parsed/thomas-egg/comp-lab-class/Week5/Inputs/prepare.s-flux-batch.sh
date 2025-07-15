#!/bin/bash
#FLUX: --job-name=prepare files
#FLUX: -t=86400
#FLUX: --priority=16

module purge
module load gromacs/openmpi/intel/2018.3
gmx_mpi grompp -f adp_T300.mdp -c adp.gro -p adp.top -o T300/adp.tpr
