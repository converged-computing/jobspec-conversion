#!/bin/bash
#FLUX: --job-name=gassy-cattywampus-2865
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: --queue=rome
#FLUX: -t=600
#FLUX: --urgency=16

module load 2022
module load GROMACS/2021.6-foss-2022a
setenv GMX_MAXCONSTRWARN -1
srun gmx grompp -f step7_production.mdp -o step7_production.tpr -c step6.6_equilibration.gro -p system.top -n index.ndx
srun gmx mdrun -deffnm step7_production -ntmpi 2 -ntomp 8
