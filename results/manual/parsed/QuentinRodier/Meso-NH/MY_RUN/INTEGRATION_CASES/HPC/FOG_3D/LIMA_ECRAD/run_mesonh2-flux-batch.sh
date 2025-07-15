#!/bin/bash
#FLUX: --job-name=phat-puppy-0004
#FLUX: --urgency=16

export MPIRUN='Mpirun -np 200'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
ln -sf ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/src/LIB/RAD/ecrad-1.4.0/data/* .
export MPIRUN="Mpirun -np 200"
set -x
set -e
ls -lrt
rm -f FOG3D.?.CE_S2.*
cp EXSEG1.nam_SEG02 EXSEG1.nam
time ${MPIRUN} MESONH${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_run2
mv OUTPUT_LISTING1  OUTPUT_LISTING1_run2
ls -lrt
rm -f EXSEG1.nam
rm -f file_for_xtransfer pipe_name PRESSURE REMAP*
ls -lrt
rm -Rf OUTPUT
mkdir OUTPUT
mv OUTPUT_L* OUTPUT
ja
