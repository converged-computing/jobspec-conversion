#!/bin/bash
#FLUX: --job-name=salted-platanos-4652
#FLUX: --urgency=16

export MPIRUN='Mpirun -np 1'

ulimit -c 0
ulimit -s unlimited
set -e
hostname
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
export MPIRUN="Mpirun -np 1"
ln -sf ../004_run_mesonh/SAL* .
ln -sf ../004_run_mesonh/Aro* .
time ${MPIRUN} DIAG${XYZ}
cd ../006_python
sbatch run_python
