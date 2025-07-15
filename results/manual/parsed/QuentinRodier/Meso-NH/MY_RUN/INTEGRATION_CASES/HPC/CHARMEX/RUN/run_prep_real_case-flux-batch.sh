#!/bin/bash
#FLUX: --job-name=doopy-banana-8175
#FLUX: --priority=16

export MPIRUN='Mpirun -np 4'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
. ~/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2-RELACS
export MPIRUN="Mpirun -np 4"
set -x
set -e
ln -sf $HOME/SAVE/GRIB_KTEST/CHARMEX/ecmwf.OD.20140630.?? .
ln -sf $HOME/SAVE/GRIB_KTEST/CHARMEX/mozart4geos5-20140629.nc .
ln -sf $HOME/SAVE/GRIB_KTEST/CHARMEX/mozart4geos5-20140630.nc .
ls -lrt
rm -f CPLCHE20140630.00.???
cp PRE_REAL1.nam_1 PRE_REAL1.nam
time ${MPIRUN} PREP_REAL_CASE${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_prep1
rm -f CPLCHE20140630.06.???
cp PRE_REAL1.nam_2 PRE_REAL1.nam
time ${MPIRUN} PREP_REAL_CASE${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_prep2
rm -f CPLCHE20140630.12.???
cp PRE_REAL1.nam_3 PRE_REAL1.nam
time ${MPIRUN} PREP_REAL_CASE${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_prep3
ls -lrt
rm -f  PRE_REAL1.nam
rm -f file_for_xtransfer pipe_name
rm -f ecmwf* mozart*
sbatch run_mesonh1
ja
