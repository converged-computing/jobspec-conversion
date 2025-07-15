#!/bin/bash
#FLUX: --job-name=persnickety-onion-0427
#FLUX: --exclusive
#FLUX: --urgency=16

module load intel
module load impi
gmxdir=/home1/03561/alarcj/gromacs/exe/gromacs-4.0.7_flatbottom/exec/bin
ppn=$1
$gmxdir/grompp -f denature_prep.mdp -c simul.gro -p tpr.top -n index.ndx -o denature_prep.tpr
ibrun $gmxdir/mdrun_mpi -np ${ppn} -v -deffnm denature_prep -append -cpi denature_prep.cpt -cpo denature_prep.cpt -maxh 47.95
$gmxdir/grompp -f denature.mdp -c denature_prep.gro -p tpr.top -n index.ndx -o denature.tpr 
ibrun $gmxdir/mdrun_mpi -np ${ppn} -v -deffnm denature -append -cpi denature.cpt -cpo denature.cpt -maxh 47.95
echo -e "0\n" | $gmxdir/trjconv -f denature_prep.trr -s denature_prep.tpr -pbc mol -o denature_prep.xtc
echo -e "0\n" | $gmxdir/trjconv -f denature.trr -s denature.tpr -pbc mol -o denature.xtc
rm *trr
rm \#*
$gmxdir/grompp -f production_prep.mdp -c denature.gro -n index.ndx -p tpr.top -o production_prep.tpr
ibrun $gmxdir/mdrun_mpi -np ${ppn} -v -deffnm production_prep -append -cpi production_prep.cpt -cpo production_prep.cpt -maxh 47.95
$gmxdir/grompp -f production.mdp -c production_prep.gro -p tpr.top -n index.ndx -o production_run.tpr
ibrun $gmxdi/mdrun_mpi -np ${ppn} -v -deffnm production_run -append -cpi production_run.cpt -cpo production_run.cpt -maxh 47.95
echo -e "0\n" | $gmxdir/trjconv -f production_prep.trr -s production_prep.tpr -pbc mol -o production_prep.xtc
echo -e "0\n" | $gmxdir/trjconv -f production_run.trr -s production_run.tpr -pbc mol -o production_run.xtc
rm *trr
rm \#*
