#!/bin/bash
#FLUX: --job-name="process"
#FLUX: --queue=shared
#FLUX: --priority=16

protname="1UBQ" 
traj="traj.xtc"
top=${protname}.tpr
gmx=`which gmx_mpi`
module load gromacs
echo "1" | $gmx trjconv -f $traj -s $top -dump 0 -o top.pdb
$gmx editconf -f top.pdb -c -center 0 0 0 -o top.pdb
top='top.pdb'
echo "3 3" | $gmx covar -f $traj -s ../../1UBQ_2.tpr -ascii
echo "3 1" | $gmx trjconv -quiet -f $traj -s $top -o after_pbc.xtc -pbc whole -center -boxcenter zero
echo "3 1" | $gmx trjconv -quiet -f after_pbc.xtc -s $top -fit rot -o after_rot.xtc
echo "3" | $gmx trjconv -quiet -f after_rot.xtc -s $top -o ${protname}.g96 -dt 1
traj="${protname}.g96"
echo "$protname" > protname.txt
nres=$( grep "CA" $top | wc -l )
echo $nres
echo "$nres" >> protname.txt
nfrs=$( grep "TIMESTEP" $traj | wc -l )
nfrs=$(( ${nfrs} - 1 ))
echo $nfrs
echo "$nfrs" >>protname.txt
natoms=$( grep "ATOM" $top | wc -l )
echo $natoms
echo $natoms >> protname.txt
echo $nres $nfrs $natoms
cp -v $top average.pdb
exit
