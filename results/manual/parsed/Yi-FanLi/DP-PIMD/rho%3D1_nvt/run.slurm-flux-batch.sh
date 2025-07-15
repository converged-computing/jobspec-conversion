#!/bin/bash
#FLUX: --job-name=lj-nvt
#FLUX: -t=3600
#FLUX: --urgency=16

export PATH='$LAMMPS_DIR:$PATH'
export OMP_NUM_THREADS='1'

LAMMPS_DIR=/scratch/gpfs/yifanl/Softwares/lammps/build
export PATH=$LAMMPS_DIR:$PATH
export OMP_NUM_THREADS=1
module purge
module load openmpi/gcc/3.1.5/64
mpirun -np 4 lmp -p 4x1 -in in.lj_nvt -log log -screen screen
