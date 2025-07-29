#!/bin/bash
#SBATCH --job-name=pspec
#SBATCH --account=cluster
#SBATCH --output=pspec.o%j
#SBATCH --error=pspec.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=1

module load compilers/intel/2019.4.243
module load intelmpi/2019.4.243
module load netcdf
set -k
WAMDIR=WAMDIR=/gpfs/home/behrens/WAM_Cycle_6
WORK=/gpfs/work/behrens/WAM_Cycle_6
cd ${WORK}/tempsg
cp ${WAMDIR}/const/Coarse_Grid/JAN/Spectra_User .
cp ${WAMDIR}/abs/pspec pspec.exe
./pspec.exe
mv Spectra_Prot ${WAMDIR}/dayfiles/coarse/pspec_prot_coarse
rm Spectra_User pspec.exe
