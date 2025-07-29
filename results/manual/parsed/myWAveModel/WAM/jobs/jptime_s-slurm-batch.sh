#!/bin/bash
#SBATCH --job-name=ptime_s
#SBATCH --output=ptime_s.o%j
#SBATCH --error=ptime_s.e%j
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
cp ${WAMDIR}/const/Time_User_S .
cp ${WAMDIR}/abs/ptime_S ptime_S.exe
./ptime_S.exe
mv Time_Prot_S ${WAMDIR}/dayfiles/ptime_S_prot_coarse_ST6
rm Time_User_S ptime_S.exe 
