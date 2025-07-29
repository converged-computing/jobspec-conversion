#!/bin/bash
#SBATCH --job-name=gmxPrep
#SBATCH --account=bdyrk14
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=04:00:00

module load hecbiosim
module load gromacs/2022.2
gmx grompp -f minim.mdp -c solv_ions.gro -p topol.top -o em.tpr
gmx mdrun -v -deffnm em
gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
gmx mdrun -v -deffnm nvt
gmx grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
gmx mdrun -v -deffnm npt
gmx grompp -f md1ns.mdp -c npt.gro -t npt.cpt -p topol.top -o md1ns.tpr
gmx mdrun -pme gpu -v -deffnm md1ns
