#!/bin/bash
#FLUX: --job-name=reclusive-lizard-6016
#FLUX: --urgency=16

export MPIRUN='Mpirun -np 128'

ulimit -c 0
ulimit -s unlimited
set -e
hostname
export MPIRUN="Mpirun -np 128"
set -x
set -e
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
ln -sf ../01_prep_ideal_case/PGDFireTest.* .
ln -sf ../01_prep_ideal_case/MNHFireTest.* .
time ${MPIRUN} MESONH${XYZ}
cd ../03_python
sbatch run_python
