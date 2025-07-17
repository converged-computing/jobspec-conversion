#!/bin/bash
#FLUX: --job-name=fugly-onion-9722
#FLUX: -c=48
#FLUX: --exclusive
#FLUX: --queue=rome
#FLUX: -t=600
#FLUX: --urgency=16

module load 2022
module load GROMACS/2021.6-foss-2022a
THREADS=48
setenv GMX_MAXCONSTRWARN -1
srun gmx_mpi mdrun -deffnm step7_production -pin on -g two_nodes.log
