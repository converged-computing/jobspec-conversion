#!/bin/bash
#FLUX: --job-name=loopy-hobbit-1980
#FLUX: --urgency=16

echo "Running Gromacs 5.x with $SLURM_NTASKS MPI tasks"
echo "Nodelist: $SLURM_NODELIST"
mpirun -np 2 --mca oob_tcp_if_include enp0s9 gmx mdrun -h
