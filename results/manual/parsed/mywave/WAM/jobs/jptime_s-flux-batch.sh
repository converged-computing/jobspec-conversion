#!/bin/bash
#FLUX: --job-name=ptime_s
#FLUX: --queue=pCluster
#FLUX: -t=300
#FLUX: --priority=16

module load compilers/intel/2019.4.243
module load intelmpi/2019.4.243
module load netcdf
set -k
WAMDIR=/gpfs/home/behrens/WAM_Cycle_6
WORK=/gpfs/work/behrens/WAM_Cycle_6
cd ${WORK}/tempsg
cp ${WAMDIR}/const/Coarse_Grid/JAN/Time_User_S .
cp ${WAMDIR}/abs/ptime_S ptime_S.exe
./ptime_S.exe
mv Time_Prot_S ${WAMDIR}/dayfiles/ptime_S_prot_coarse
rm Time_User_S ptime_S.exe 
