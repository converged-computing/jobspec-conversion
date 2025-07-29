#!/bin/bash
#SBATCH --job-name=rt_mpi
#SBATCH --output=rt_mpi.out
#SBATCH --error=rt_mpi.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1

module load openmpi-x86_64
mpirun -np $SLURM_NPROCS raytrace_mpi -h 5000 -w 5000 -c configs/twhitted.xml -p dynamic -bh 50 -bw 50 
