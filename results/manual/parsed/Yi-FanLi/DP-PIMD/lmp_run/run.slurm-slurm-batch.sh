#!/bin/bash
#FLUX: --job-name=water_se_run
#FLUX: -n=28
#FLUX: -t=360000
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load anaconda3
conda activate dpdev
out_path=`pwd`
cd $out_path
mpirun -np 8 lmp -in in.lammps -p 8x1 -log log -screen screen
