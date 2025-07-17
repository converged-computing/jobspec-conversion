#!/bin/bash
#FLUX: --job-name=bloated-staircase-0942
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

module load hecbiosim
module add gromacs/2020.4-plumed-2.6.2
gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr -maxwarn 1
bede-mpirun --bede-par 1ppg mdrun_mpi -deffnm nvt
gmx grompp -f npt.mdp -c nvt.gro -r em.gro -p topol.top -o npt.tpr -maxwarn 1
bede-mpirun --bede-par 1ppg mdrun_mpi -deffnm npt
gmx grompp -f prod_sc.mdp -c npt.gro -r em.gro -p topol.top -o prod_sc.tpr
bede-mpirun --bede-par 1ppg mdrun_mpi -deffnm prod_sc
