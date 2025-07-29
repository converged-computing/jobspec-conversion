#!/bin/bash
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --partition=cpu
#SBATCH --constraint=ntasks-per-node=40

module purge
module load gromacs/2019.4-gcc-9.2.0-openmpi
ulimit -s unlimited
ulimit -l unlimited
srun --mpi=pmi2 gmx_mpi mdrun -s ion_channel.tpr -maxh 0.50 -resethway -noconfout -nsteps 10000
