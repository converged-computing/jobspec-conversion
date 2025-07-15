#!/bin/bash
#FLUX: --job-name="md"
#FLUX: --priority=16

PDB=$1
FF=$2
H2O=$3
protname=`echo ${PDB} | sed "s#\.# #g" | awk '{ print $1}'`
echo $protname
echo $protname > protname.txt
module load openmpi/4.0.4
module load gromacs/2020.4
gmx_mpi pdb2gmx -f $PDB -o out.gro -p sys.top -ignh < inp
gmx_mpi editconf -f out.gro -bt cubic -d 0.9 -o boxed.gro
gmx_mpi solvate -cp boxed.gro -p sys.top -o solvated.pdb
touch ions.mdp
gmx_mpi grompp -c solvated.pdb -r solvated.pdb -f ions.mdp -p sys.top -o ions.tpr -maxwarn 5
echo "SOL" | gmx_mpi genion -s ions.tpr -p sys.top -o ${protname}.gro -neutral -conc 0.1
gmx_mpi grompp -v -f em.mdp -c ${protname}.gro -o em_${protname}.tpr -p sys.top
gmx_mpi mdrun -v -s em_${protname}.tpr -o em_${protname}.trr -c after_em_${protname}.gro -g em_${protname}.log -ntomp 1
