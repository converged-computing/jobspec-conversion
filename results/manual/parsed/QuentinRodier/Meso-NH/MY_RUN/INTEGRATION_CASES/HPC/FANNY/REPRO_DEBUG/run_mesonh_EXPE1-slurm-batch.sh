#!/bin/bash
#FLUX: --job-name=run1_fanny
#FLUX: -N=20
#FLUX: -n=200
#FLUX: -t=1200
#FLUX: --urgency=16

export MPIRUN='Mpirun -np 200'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-DEBUG
ln -sf ../ICE3/PGD_2.5km_AR.* .
ln -sf ../ICE3/A_2008090* .
export MPIRUN="Mpirun -np 200"
set -x
set -e
ls -lrt
cp -f EXSEG1.nam_EXPE1 EXSEG1.nam
time ${MPIRUN} MESONH${XYZ}
mv OUTPUT_LISTING1 OUTPUT_LISTING1_EXPE1
rm -f file_for_xtransfer pipe_name PRESSURE REMAP*
ja
