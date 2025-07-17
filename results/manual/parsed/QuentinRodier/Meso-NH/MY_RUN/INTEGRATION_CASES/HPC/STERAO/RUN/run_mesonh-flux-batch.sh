#!/bin/bash
#FLUX: --job-name=run_sterao
#FLUX: -N=4
#FLUX: -n=192
#FLUX: -t=14400
#FLUX: --urgency=16

export MPIRUN='Mpirun -np 192'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-DEBUG-STERAO
export MPIRUN="Mpirun -np 192"
set -x
set -e
ls -lrt
rm -f STERA.1.CEN4T.* STERA_fgeom*
time ${MPIRUN} MESONH${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_run
mv OUTPUT_LISTING1  OUTPUT_LISTING1_run
ls -lrt
rm -f file_for_xtransfer pipe_name PRESSURE REMAP*
ls -lrt
mkdir OUTPUT
mv OUTPUT_L* OUTPUT
mkdir LFI
mv *.lfi LFI/.
mv *.des LFI/.
ja
