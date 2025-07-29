#!/bin/bash
#SBATCH --nodes=5
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=sgpu

module load intel
module load impi
module load mkl
source /projects/beco4952/pkgs/gromacs/2018_gpu/bin/GMXRC
for dir in sim{0..19}; do cd $dir; gmx grompp -f berendsen.mdp -c em_solvated.gro -p topol.top -o berendsen; cd ..; done
mpirun -np 20 gmx_mpi mdrun -v -multidir sim{0..19} -deffnm berendsen -ntomp 6
