#!/bin/bash
#FLUX: --job-name=outstanding-underoos-8318
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=rome
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

module load 2022
module load GROMACS/2021.6-foss-2022a
THREADS=24
setenv GMX_MAXCONSTRWARN -1
export OMP_NUM_THREADS=1
srun gmx_mpi mdrun -deffnm step7_production -pin on -g two_nodes.log 
