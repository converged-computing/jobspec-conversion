#!/bin/bash
#FLUX: --job-name=crusty-pedo-4053
#FLUX: --priority=16

module load lammps/2018/cuda
echo
echo  ==============================
echo
mpirun -np 16 lmp -sf gpu -pk gpu 4 -in dpd_water_100x100x100_t1000.txt
echo
echo  ==============================
echo
mpirun -np 16 lmp -sf gpu -pk gpu 2 -in dpd_water_100x100x100_t1000.txt
echo
echo  ==============================
echo
mpirun -np 16 lmp -sf gpu -pk gpu 1 -in dpd_water_100x100x100_t1000.txt
