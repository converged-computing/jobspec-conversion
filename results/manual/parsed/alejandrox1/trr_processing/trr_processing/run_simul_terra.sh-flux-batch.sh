#!/bin/bash
#FLUX: --job-name=crunchy-cinnamonbun-9291
#FLUX: --exclusive
#FLUX: -t=172800
#FLUX: --urgency=16

module load mpi/openmpi
gmxdir=/home/alarcj/exe/gromacs-4.0.7_flatbottom/exec/bin
$gmxdir/grompp -f this.mdp -c nvt.gro -p topol.top -o simul_equil.tpr -n this.ndx -maxwarn 1
mpirun -np 8 $gmxdir/mdrun_mpi -np 8 -v -deffnm simul_equil -px pullx.xvg -pf pullf.xvg -append -cpi simul_equil.cpt -cpo simul_equil.cpt -maxh 47.95
$gmxdir/trjconv -f simul_equil.trr -s simul_equil.tpr -pbc mol -o simul_equil.xtc
rm -rf \#* step*.pdb
rm *trr
