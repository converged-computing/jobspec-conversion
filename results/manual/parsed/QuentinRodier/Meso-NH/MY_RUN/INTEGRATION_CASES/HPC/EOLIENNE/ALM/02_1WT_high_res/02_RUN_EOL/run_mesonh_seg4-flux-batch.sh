#!/bin/bash
#FLUX: --job-name=strawberry-carrot-3852
#FLUX: --urgency=16

export MPIRUN='Mpirun -np 2048'

ulimit -c 0
ulimit -s unlimited
set -e
hostname
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
export MPIRUN="Mpirun -np 2048"
set -x
set -e
cp EXSEG1.nam_SEG4 EXSEG1.nam
time ${MPIRUN} MESONH${XYZ}
rm -f file_for_xtransfer pipe_name
mv OUTPUT_LISTING0 OUTPUT_LISTING0_SEG4
mv OUTPUT_LISTING1 OUTPUT_LISTING1_SEG4
sbatch run_python
