#!/bin/bash
#FLUX: --job-name=SM_npt_umbrella
#FLUX: -n=10
#FLUX: -t=7200
#FLUX: --urgency=16

ml purge
ml ABINIT/8.10.3 Armadillo/9.700.2 CDO/1.9.5 GOTM/5.3-221-gac7ec88d NCO/4.8.1 NCO/4.9.2 OpenFOAM/6 OpenFOAM/7 OpenFOAM/v1912 Rosetta/3.7 Siesta/4.1-MaX-1.0 Siesta/4.1-b4 Singular/4.1.2 XCrySDen/1.5.60 XCrySDen/1.6.2 deal.II/9.1.1-gcc deal.II/9.1.1-intel
ml gromacs/2019.6.th
gmx grompp -f npt.mdp -c em.gro -p topol.top -r em.gro -o npt.tpr -maxwarn 3
gmx mdrun -nt 10 -v -deffnm npt
