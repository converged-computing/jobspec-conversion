#!/bin/bash
#SBATCH --account=bdhbs02
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu

module load hecbiosim
module add gromacs/2020.4-plumed-2.6.2
gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr -maxwarn 1
bede-mpirun --bede-par 1ppg mdrun_mpi -deffnm nvt
gmx grompp -f npt.mdp -c nvt.gro -r em.gro -p topol.top -o npt.tpr -maxwarn 1
bede-mpirun --bede-par 1ppg mdrun_mpi -deffnm npt
gmx grompp -f prod_sc.mdp -c npt.gro -r em.gro -p topol.top -o prod_sc.tpr
bede-mpirun --bede-par 1ppg mdrun_mpi -deffnm prod_sc
