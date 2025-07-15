#!/bin/bash
#FLUX: --job-name=10_1_-1_0.2_0.2_0.1_-0.01
#FLUX: -N=4
#FLUX: -t=28800
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

module load lammps/2Aug2023
cd $SLURM_SUBMIT_DIR
export OMP_NUM_THREADS=1
time srun -n 96 -d 1 lmp_mpi < in.lammps
