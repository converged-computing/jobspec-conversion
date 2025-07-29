#!/bin/bash
#SBATCH --job-name=AIB9
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=2-00:00:00

module load cuda
module load gcc
module load openmpi
module load gromacs
gmx_mpi grompp -f step5_production.mdp -p topol.top -r step5_1.gro -c step5_1.gro -maxwarn 5 -o pro.tpr
mpirun gmx_mpi mdrun -v -deffnm pro -nb gpu
