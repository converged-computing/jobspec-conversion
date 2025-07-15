#!/bin/bash
#FLUX: --job-name=Hamiltonian_Solver_agrace
#FLUX: -n=3
#FLUX: -t=43200
#FLUX: --urgency=16

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
srun --mpi=pmix_v2 matgen 3 csvs/weicheng.csv 
