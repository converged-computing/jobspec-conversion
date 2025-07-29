#!/bin/bash
#SBATCH --job-name=gmx_run
#SBATCH --account=harmslab
#SBATCH --output=hostname.out
#SBATCH --error=hostname.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH --time=7-00:00:00
#SBATCH --partition=longfat
#SBATCH --constraint=ntasks-per-node=1

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
