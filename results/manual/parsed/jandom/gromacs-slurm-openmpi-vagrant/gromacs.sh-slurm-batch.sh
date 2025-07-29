#!/bin/bash
#SBATCH --job-name=gromacs_job
#SBATCH --output=gromacs_job.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00

echo "Running Gromacs 5.x with $SLURM_NTASKS MPI tasks"
echo "Nodelist: $SLURM_NODELIST"
mpirun -np 2 --mca oob_tcp_if_include enp0s9 gmx mdrun -h
