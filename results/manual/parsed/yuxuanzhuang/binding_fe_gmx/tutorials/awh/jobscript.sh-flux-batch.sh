#!/bin/bash
#FLUX: --job-name=crusty-signal-2002
#FLUX: --priority=16

module unload gromacs
module switch gromacs/2023 gromacs=gmx_mpi
module switch cuda/11.8
module unload openmpi
module load openmpi
cd AWH
srun -n 4 gmx_mpi mdrun -deffnm awh -cpi awh -multidir rep{1..4} -pme gpu -bonded gpu -nb gpu -px awh_pullx -pf awh_pullf -maxh 23
