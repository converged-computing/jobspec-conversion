#!/bin/bash
#SBATCH --job-name=mpi_job_test
#SBATCH --output=mpi_test_%j.out
#SBATCH --mail-user=<email_address>
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1gb
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=12,ntasks-per-socket=6

echo "Date start        = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
echo ""
echo "Running prime number generator program on $SLURM_JOB_NUM_NODES nodes with $SLURM_NTASKS tasks, each with $SLURM_CPUS_PER_TASK cores."
echo ""
module load intel/2020 openmpi/4
srun --mpi=pmix_v3 /data/training/SLURM/prime/prime_mpi
echo ""
echo "Date end          = $(date)"
