#!/bin/bash
#FLUX: --job-name=Preferential
#FLUX: -N=2
#FLUX: -n=32
#FLUX: --exclusive
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --urgency=16

module load intel
module load impi
gmxdir=/home1/03561/alarcj/gromacs/exe/gromacs-4.0.7_flatbottom/exec/bin
nnodes=$1
ppn=$2
name=$3
echo -e "0\nq\n" | $gmxdir/make_ndx -f min.gro -o index.ndx
$gmxdir/grompp -f simul_prep.mdp -c min.gro -n index.ndx -p tpr.top -o simul_prep.tpr 
ibrun $gmxdir/mdrun_mpi -np ${ppn} -v -deffnm simul_prep -append -cpi simul_prep.cpt -cpo simul_prep.cpt -maxh 47.95
$gmxdir/grompp -f simul.mdp -c simul_prep.gro -n index.ndx -p tpr.top -o simul.tpr
ibrun $gmxdir/mdrun_mpi -np ${ppn} -v -deffnm simul -append -cpi simul.cpt -cpo simul.cpt -maxh 47.95
echo -e "0\n" | $gmxdir/trjconv -f simul_prep.trr -s simul_prep.tpr -pbc mol -o simul_prep.xtc
echo -e "0\n" | $gmxdir/trjconv -f simul.trr -s simul.tpr -pbc mol -o simul.xtc
rm *trr
