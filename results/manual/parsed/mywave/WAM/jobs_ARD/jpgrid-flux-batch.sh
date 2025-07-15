#!/bin/bash
#FLUX: --job-name=pgrid
#FLUX: --queue=pCluster
#FLUX: -t=1800
#FLUX: --priority=16

module load compilers/intel/2019.4.243
module load intelmpi/2019.4.243
module load netcdf
set -k
WAMDIR=/gpfs/home/behrens/WAM_Cycle_6
WORK=/gpfs/work/behrens/WAM_Cycle_6
cd ${WORK}/tempsg
cp ${WAMDIR}/const/Coarse_Grid/ARD/Grid_User .
cp ${WAMDIR}/abs/pgrid pgrid.exe
./pgrid.exe
mv Grid_Prot ${WAMDIR}/dayfiles/pgrid_prot_coarse_ARD
rm Grid_User pgrid.exe
