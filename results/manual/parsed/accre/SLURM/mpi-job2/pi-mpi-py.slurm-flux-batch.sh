#!/bin/bash
#FLUX: --job-name=pi-mpi
#FLUX: --queue=production
#FLUX: -t=300
#FLUX: --priority=16

module load GCC OpenMPI Python numpy mpi4py
echo "Starting calculation at $(date)"
srun python pi-mpi.py
echo "Completed calculation at $(date)"
