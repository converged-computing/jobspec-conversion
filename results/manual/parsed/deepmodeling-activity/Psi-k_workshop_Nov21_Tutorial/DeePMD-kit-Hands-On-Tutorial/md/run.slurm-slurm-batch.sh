#!/bin/bash
#FLUX: --job-name=water_run
#FLUX: -n=28
#FLUX: -t=72000
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load anaconda3
conda activate mpi-test
out_path=`pwd`
cd $out_path
mpirun -np 16 lmp -in in.lammps
