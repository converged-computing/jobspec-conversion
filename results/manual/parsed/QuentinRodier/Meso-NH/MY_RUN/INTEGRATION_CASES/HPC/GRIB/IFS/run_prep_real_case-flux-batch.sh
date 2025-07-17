#!/bin/bash
#FLUX: --job-name=prep_ifs
#FLUX: -n=2
#FLUX: -t=1800
#FLUX: --urgency=16

export MPIRUN='Mpirun -np 2'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
export MPIRUN="Mpirun -np 2"
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
ln -sf ../PGD/PGD_FRANCE* .
ln -sf ~rodierq/SAVE/GRIB_KTEST/ecmwf.OD.20180513.00 .
set -x
set -e
time ${MPIRUN} PREP_REAL_CASE${XYZ}
sbatch run_python
