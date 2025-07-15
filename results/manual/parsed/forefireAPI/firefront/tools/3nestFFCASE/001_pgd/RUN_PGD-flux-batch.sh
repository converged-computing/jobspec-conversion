#!/bin/bash
#FLUX: --job-name=misunderstood-destiny-1110
#FLUX: -n=4
#FLUX: --exclusive
#FLUX: --queue=intel
#FLUX: -t=72000
#FLUX: --priority=16

export MPIRUN='mpirun -np 4'

echo "SCRIPT RUN_PGD EN COURS"
ulimit -c 0
ulimit -s unlimited
hostname 
. ~/runMNH              
export MPIRUN="mpirun -np 4"
ln -sf $MESONH/PGD/ECOCLIMAP_v2.0.* .
ln -sf $MESONH/PGD/srtm_europe.* .
ln -sf $MESONH/PGD/CLAY_HWSD_MOY.* .
ln -sf $MESONH/PGD/SAND_HWSD_MOY.* .
cp PRE_PGD1.nam_2000m PRE_PGD1.nam
time ${MPIRUN} PREP_PGD${XYZ}
cp PRE_PGD1.nam_400m PRE_PGD1.nam
time ${MPIRUN} PREP_PGD${XYZ}
cp PRE_PGD1.nam_80m PRE_PGD1.nam
time ${MPIRUN} PREP_PGD${XYZ}
time ${MPIRUN} PREP_NEST_PGD${XYZ}
