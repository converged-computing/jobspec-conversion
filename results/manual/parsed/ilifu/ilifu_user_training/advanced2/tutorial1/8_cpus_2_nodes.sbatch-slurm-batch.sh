#!/bin/bash
#SBATCH --job-name=8-cpus-2-nodes
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1GB
#SBATCH --time=00:01:00
#SBATCH --constraint=ntasks-per-node=4

echo "Submitting SLURM job: simple_mpi.py using 8 cores & 2 nodes"
module add openmpi/4.0.3
mpirun python simple_mpi.py
