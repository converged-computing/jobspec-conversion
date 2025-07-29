#!/bin/bash
#SBATCH --job-name=Hamiltonian_Solver_agrace
#SBATCH --output=slurm_logs/mpi_test_%j.log
#SBATCH --mail-user=agrace2@binghamton.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=3
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4GB
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=3,ntasks-per-socket=3

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
srun --mpi=pmix_v2 matgen 3 csvs/weicheng.csv 
