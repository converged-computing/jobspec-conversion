#!/bin/bash
#FLUX: --job-name=hello-punk-4294
#FLUX: --queue=gtx1080
#FLUX: --urgency=16

module load lammps/2018/cuda
echo
echo  ==============================
echo
mpirun -np 16 lmp -sf gpu -pk gpu 1 -in dpd_water_100x100x100_t1000.txt
echo
echo  ==============================
echo
mpirun -np 16 lmp -sf gpu -pk gpu 2 -in dpd_water_100x100x100_t1000.txt
echo
echo  ==============================
echo
mpirun -np 16 lmp -sf gpu -pk gpu 4 -in dpd_water_100x100x100_t1000.txt
echo
echo  ==============================
echo
mpirun -np 16 lmp -sf gpu -pk gpu 0 -in dpd_water_100x100x100_t1000.txt
