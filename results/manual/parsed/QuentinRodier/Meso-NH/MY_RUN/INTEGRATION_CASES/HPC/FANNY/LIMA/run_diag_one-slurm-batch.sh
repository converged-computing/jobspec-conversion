#!/bin/bash
#FLUX: --job-name=diag_fanny
#FLUX: -n=128
#FLUX: -t=600
#FLUX: --urgency=16

export MPIRUN='Mpirun -np 128'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
export MPIRUN="Mpirun -np 128"
set -x
set -e
ls -lrt
time ${MPIRUN} DIAG${XYZ}
