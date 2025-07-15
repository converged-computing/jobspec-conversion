#!/bin/bash
#FLUX: --job-name=adorable-spoon-2627
#FLUX: --urgency=16

export MPIRUN='Mpirun -np 64'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
export MPIRUN="Mpirun -np 64"
set -x
set -e
ls -lrt
rm -f K_MAP.?.WENO5.*
time ${MPIRUN} MESONH${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_run
mv OUTPUT_LISTING1  OUTPUT_LISTING1_run
mv OUTPUT_LISTING2  OUTPUT_LISTING2_run
mv OUTPUT_LISTING3  OUTPUT_LISTING3_run
rm -f file_for_xtransfer pipe_name PRESSURE REMAP*
sbatch run_diag
ja
