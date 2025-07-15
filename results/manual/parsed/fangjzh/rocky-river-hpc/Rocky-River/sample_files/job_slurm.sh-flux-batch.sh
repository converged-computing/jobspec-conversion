#!/bin/bash
#FLUX: --job-name=test
#FLUX: -n=48
#FLUX: --queue=normal
#FLUX: --urgency=16

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
module load mpi
mpirun -np $SLURM_NTASKS /opt/ohpc/pub/apps/lammps-stable_23Jun2022_update3/src/lmp_mpi -i in.eam
