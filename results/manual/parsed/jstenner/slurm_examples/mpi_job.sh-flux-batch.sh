#!/bin/bash
#FLUX: --job-name=mpi_job_test
#FLUX: -N=2
#FLUX: -n=24
#FLUX: -t=300
#FLUX: --urgency=16

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
