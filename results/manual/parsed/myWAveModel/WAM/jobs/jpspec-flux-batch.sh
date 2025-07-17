#!/bin/bash
#FLUX: --job-name=pspec
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
cp ${WAMDIR}/const/Spectra_User .
cp ${WAMDIR}/abs/pspec pspec.exe
./pspec.exe
mv Spectra_Prot ${WAMDIR}/dayfiles/pspec_prot_coarse_ST6
rm Spectra_User pspec.exe
