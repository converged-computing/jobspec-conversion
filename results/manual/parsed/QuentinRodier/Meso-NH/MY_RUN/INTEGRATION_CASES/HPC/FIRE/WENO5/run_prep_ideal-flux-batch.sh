#!/bin/bash
#FLUX: --job-name=adorable-motorcycle-1473
#FLUX: --urgency=16

export MPIRUN='Mpirun -np 1'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
export MPIRUN="Mpirun -np 1"
set -x
set -e
ls -lrt
rm -f FIRE_LES.??? FIRE_PGD.???
time ${MPIRUN} PREP_IDEAL_CASE${XYZ}
mv OUTPUT_LISTING1  OUTPUT_LISTING1_ideal
touch FIRE_PGD.des
ls -lrt 
rm -f file_for_xtransfer pipe_name
ls -lrt 
sbatch run_mesonh
ja
