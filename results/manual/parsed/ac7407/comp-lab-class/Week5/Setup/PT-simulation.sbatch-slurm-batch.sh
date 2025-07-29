#!/bin/bash
#SBATCH --job-name=PT-simulation
#SBATCH --output=PT-simulation.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8GB
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=4

module purge
module load gromacs/openmpi/intel/2018.3
mpirun -np 4 gmx_mpi mdrun -s adp -multidir T300/ T350 T400/ T450 -deffnm adp_exchange4temps -replex 50
