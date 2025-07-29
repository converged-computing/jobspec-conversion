#!/bin/bash
#SBATCH --job-name=H25
#SBATCH --output=slurm_logs/mpi_test_%j.log
#SBATCH --mail-user=agrace2@binghamton.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=128000MB
#SBATCH --time=00:10:00
#SBATCH --partition=RM-shared
#SBATCH --constraint=ntasks-per-node=64

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
srun --mpi=pmi2 ./matgen 25 range 1 5 0.0 5.0 5 0.0 5.0 --run-performance-metrics --use-petsc-only-methods
