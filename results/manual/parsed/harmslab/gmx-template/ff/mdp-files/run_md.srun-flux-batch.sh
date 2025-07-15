#!/bin/bash
#FLUX: --job-name=gmx_run      ### job name
#FLUX: -c=28
#FLUX: --queue=longfat
#FLUX: -t=604800
#FLUX: --priority=16

module load intel/19
module load gromacs/2019.4
gmx grompp -f em.mdp -c system.gro -p topol.top -o em.tpr
gmx mdrun -v -deffnm em
gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
gmx mdrun -deffnm nvt
gmx grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
gmx mdrun -deffnm npt
gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_1.tpr
gmx mdrun -deffnm md_0_1 
