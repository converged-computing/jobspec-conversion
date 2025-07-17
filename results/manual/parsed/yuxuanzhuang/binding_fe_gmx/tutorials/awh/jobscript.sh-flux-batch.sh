#!/bin/bash
#FLUX: --job-name=awh_epj
#FLUX: -n=4
#FLUX: --queue=lindahl1,lindahl2,lindahl3,lindahl4
#FLUX: -t=86400
#FLUX: --urgency=16

module unload gromacs
module switch gromacs/2023 gromacs=gmx_mpi
module switch cuda/11.8
module unload openmpi
module load openmpi
cd AWH
srun -n 4 gmx_mpi mdrun -deffnm awh -cpi awh -multidir rep{1..4} -pme gpu -bonded gpu -nb gpu -px awh_pullx -pf awh_pullf -maxh 23
