#!/bin/bash
#FLUX: --job-name=ptime
#FLUX: --queue=pCluster
#FLUX: -t=300
#FLUX: --urgency=16

module load compilers/intel/2019.4.243
module load intelmpi/2019.4.243
module load netcdf
set -k
WAMDIR=/gpfs/home/ricker/WAM/WAM_Cycle7_test
WORK=/gpfs/work/ricker/storage/WAM/WAM_Cycle7_test
cd ${WORK}/tempsg
cp ${WAMDIR}/const/Time_User .
cp ${WAMDIR}/abs/ptime ptime.exe
./ptime.exe
mv Time_Prot ${WAMDIR}/dayfiles/ptime_prot_coarse_ST6
rm Time_User ptime.exe 
