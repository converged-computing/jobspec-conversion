#!/bin/bash
#FLUX: --job-name=RECT_AA
#FLUX: --queue=yethiraj
#FLUX: -t=86400
#FLUX: --urgency=16

time mpirun -n 4 gmx_mpi mdrun -deffnm md -cpi md.cpt -plumed ../plumed_rect.dat -multidir topol0 topol1 topol2 topol3 -replex 500 -nsteps 500000000 -pin on -maxh 48 -ntomp 1
