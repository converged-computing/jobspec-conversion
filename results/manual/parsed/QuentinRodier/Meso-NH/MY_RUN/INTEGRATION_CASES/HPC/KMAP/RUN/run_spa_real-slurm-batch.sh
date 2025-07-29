#!/bin/bash
#FLUX: --job-name=sparea_kmap
#FLUX: -t=1200
#FLUX: --urgency=16

export MPIRUN='Mpirun -np 1'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
. ~rodierq//DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
export MPIRUN="Mpirun -np 1"
set -x
set -e
ls -lrt
rm -f CPL_19990917.12.spa04.???
cp SPAWN1.nam_1 SPAWN1.nam
time ${MPIRUN} SPAWNING${XYZ}
mv OUTPUT_LISTING1  OUTPUT_LISTING1_spa1
mv OUTPUT_LISTING2  OUTPUT_LISTING2_spa1
ls -lrt
rm -f  CPL_19990917.12.2.???
cp PRE_REAL1.nam_dom2 PRE_REAL1.nam
time ${MPIRUN} PREP_REAL_CASE${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_prepdom2
mv OUTPUT_LISTING1  OUTPUT_LISTING1_prepdom2
ls -lrt
rm -f CPL_19990917.12.2.spa04.???
cp SPAWN1.nam_2 SPAWN1.nam
time ${MPIRUN} SPAWNING${XYZ}
mv OUTPUT_LISTING1  OUTPUT_LISTING1_spa2
mv OUTPUT_LISTING2  OUTPUT_LISTING2_spa2
ls -lrt
rm -f  CPL_19990917.12.3.???
cp PRE_REAL1.nam_dom3 PRE_REAL1.nam
time ${MPIRUN} PREP_REAL_CASE${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_prepdom3
mv OUTPUT_LISTING1  OUTPUT_LISTING1_prepdom3
ls -lrt
rm -f PRE_REAL1.nam SPAWN1.nam
rm -f file_for_xtransfer pipe_name
sbatch run_mesonh
ja
