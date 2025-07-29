#!/bin/bash
#SBATCH --job-name=pspec
#SBATCH --output=pspec.o%j
#SBATCH --error=pspec.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=pCluster
#SBATCH --constraint=ntasks-per-node=1

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
