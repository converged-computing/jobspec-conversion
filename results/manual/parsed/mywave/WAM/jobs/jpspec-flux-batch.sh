#!/bin/bash
#FLUX: --job-name=pspec
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
cp ${WAMDIR}/const/Coarse_Grid/JAN/Spectra_User .
cp ${WAMDIR}/abs/pspec pspec.exe
./pspec.exe
mv Spectra_Prot ${WAMDIR}/dayfiles/pspec_prot_coarse_JAN
rm Spectra_User pspec.exe
