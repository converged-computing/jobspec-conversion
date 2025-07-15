#!/bin/bash
#FLUX: --job-name=butterscotch-parrot-1590
#FLUX: -n=16
#FLUX: -t=86400
#FLUX: --urgency=16

module load  gcc/7.3.0 openmpi/3.1.2 gromacs/2020.2
gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -n index.ndx -o md_0_10.tpr
gmx mdrun -np -deffnm md_0_10
