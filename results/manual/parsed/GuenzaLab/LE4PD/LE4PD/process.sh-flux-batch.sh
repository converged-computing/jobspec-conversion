#!/bin/bash
#FLUX: --job-name="process"
#FLUX: --queue=shared
#FLUX: --priority=16

protname="1UBQ" 
traj="traj.xtc"
top=${protname}.tpr
gmx=`which gmx_mpi`
module load gromacs
echo "1 1" | $gmx trjconv -f $traj -s $top -o ${protname}.xtc -pbc cluster  #fix periodic boundary conditions
echo "3" | $gmx trjconv -f ${protname}.xtc -s $top -o ${protname}_rot.g96 #alpha-carbons with rotations
echo "1 1" | $gmx trjconv -f ${protname}.xtc -s $top -o ${protname}.xtc -fit rot+trans #remove rotations and translations of protein
echo "3" | $gmx trjconv -f ${protname}.xtc -s $top -o ${protname}.g96  #alpha-carbons 
echo "1" | $gmx trjconv -f ${protname}.xtc -o ${protname}_first.pdb -s $top -dump 0 #make pdb file
echo "1" | $gmx trjconv -f ${protname}.xtc -o ${protname}.gro -s $top -dump 0 #make .gro file
echo "1" | $gmx sasa -f ${protname}.xtc -s $top -or resarea.xvg  -dt 1000 #solvent exposed surface area calculation
exit
