#!/bin/bash
#FLUX: --job-name=H25
#FLUX: --queue=RM-shared
#FLUX: -t=600
#FLUX: --urgency=16

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
srun --mpi=pmi2 ./matgen 25 range 1 5 0.0 5.0 5 0.0 5.0 --run-performance-metrics --use-petsc-only-methods
