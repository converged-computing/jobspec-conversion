#!/bin/bash
#SBATCH --output=job_%j.out
#SBATCH --error=job_%j.err
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --partition=sched_mit_hill
#SBATCH --constraint=ntasks-per-node=16

mpiexec echo "test"
