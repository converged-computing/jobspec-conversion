#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00
#SBATCH --partition=interactive
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=2

module load OpenMPI
hpcstruct amg2006 
srun -n 4 hpcprof-mpi -S amg2006.hpcstruct hpctoolkit-all-measurements
