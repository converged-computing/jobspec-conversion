#!/bin/bash
#FLUX: --job-name=ptime
#FLUX: --queue=pCluster
#FLUX: -t=300
#FLUX: --urgency=16

module load compilers/intel/2019.4.243
module load intelmpi/2019.4.243
module load netcdf
set -k
WAMDIR=WAMDIR=/gpfs/home/behrens/WAM_Cycle_6
WORK=/gpfs/work/behrens/WAM_Cycle_6
cd ${WORK}/tempsg
cp ${WAMDIR}/const/Coarse_Grid/JAN/Time_User .
cp ${WAMDIR}/abs/ptime ptime.exe
./ptime.exe
mv Time_Prot ${WAMDIR}/dayfiles/coarse/ptime_prot_coarse
rm Time_User ptime.exe 
